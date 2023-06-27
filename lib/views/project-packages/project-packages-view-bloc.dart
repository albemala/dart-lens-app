import 'dart:async';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:dart_lens/blocs/project-analysis-bloc.dart';
import 'package:dart_lens/functions/installed-packages.dart';
import 'package:dart_lens/functions/packages.dart';
import 'package:dart_lens/functions/project-packages-analysis.dart';
import 'package:dart_lens/models/package/package.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_api_client/pub_api_client.dart';

part 'project-packages-view-bloc.freezed.dart';

enum PackageFilter {
  all(title: 'All'),
  upgradable(title: 'Upgradable');

  final String title;

  const PackageFilter({
    required this.title,
  });
}

@freezed
class ProjectPackagesViewModel with _$ProjectPackagesViewModel {
  const ProjectPackagesViewModel._();

  const factory ProjectPackagesViewModel({
    required bool isLoading,
    required PackageFilter packageFilter,
    required int packageVersionsToChangeCount,
    required IList<PackageViewModel> dependencies,
    required IList<PackageViewModel> devDependencies,
  }) = _ProjectPackagesViewModel;
}

@freezed
class PackageViewModel with _$PackageViewModel {
  const PackageViewModel._();

  const factory PackageViewModel({
    required String name,
    required String? installedVersion,
    required String? installableVersion,
    required String? changeToVersion,
    required IList<PackageVersionViewModel>? availableVersions,
    required bool isLatestVersionInstalled,
    required String? url,
    required String? changelogUrl,
    required String? description,
  }) = _PackageViewModel;
}

@freezed
class PackageVersionViewModel with _$PackageVersionViewModel {
  const PackageVersionViewModel._();

  const factory PackageVersionViewModel({
    required String version,
    required bool isInstalled,
    required bool isInstallable,
    required bool willBeInstalled,
    required bool willBeUninstalled,
  }) = _PackageVersionViewModel;
}

PackageViewModel _createPackageViewModel(
  Package package,
  IMap<String, String> packageVersionsToChange,
) {
  final changeToVersion = packageVersionsToChange[package.name];
  final availableVersions = package.availableVersions?.map((availableVersion) {
    return _createPackageVersionViewModel(
      package,
      availableVersion,
      changeToVersion,
    );
  }).toIList();
  return PackageViewModel(
    name: package.name,
    installedVersion: package.installedVersion,
    installableVersion: package.resolvableVersion,
    changeToVersion: changeToVersion,
    availableVersions: availableVersions,
    isLatestVersionInstalled: isPackageLatestVersionInstalled(package),
    url: package.url,
    changelogUrl: package.changelogUrl,
    description: package.description,
  );
}

PackageVersionViewModel _createPackageVersionViewModel(
  Package package,
  PackageVersion availableVersion,
  String? changeToVersion,
) {
  final isInstalled = package.installedVersion == availableVersion.version;
  return PackageVersionViewModel(
    version: availableVersion.version,
    isInstalled: isInstalled,
    isInstallable: isPackageInstallable(package, availableVersion),
    willBeInstalled: !isInstalled &&
        changeToVersion != null &&
        changeToVersion == availableVersion.version,
    willBeUninstalled: isInstalled &&
        changeToVersion != null &&
        changeToVersion != availableVersion.version,
  );
}

class ProjectPackagesViewBloc extends Cubit<ProjectPackagesViewModel> {
  final BuildContext context;
  late StreamSubscription<ProjectAnalysisBlocState> projectAnalysisBlocListener;

  List<Package> packages = [];
  IMap<String, String> packageVersionsToChange = <String, String>{}.lock;

  String? get _projectPath {
    final projectAnalysisBlocState = context.read<ProjectAnalysisBloc>().state;
    return projectAnalysisBlocState.projectPath;
  }

  ProjectPackagesViewBloc(this.context)
      : super(
          ProjectPackagesViewModel(
            isLoading: false,
            packageFilter: PackageFilter.all,
            packageVersionsToChangeCount: 0,
            dependencies: <PackageViewModel>[].lock,
            devDependencies: <PackageViewModel>[].lock,
          ),
        ) {
    projectAnalysisBlocListener = context //
        .read<ProjectAnalysisBloc>()
        .stream
        .listen((projectAnalysisBlocState) {
      reload();
    });
    reload();
  }

  @override
  Future<void> close() {
    projectAnalysisBlocListener.cancel();
    return super.close();
  }

  void setPackageFilter(PackageFilter filter) {
    emit(
      state.copyWith(
        packageFilter: filter,
      ),
    );
    _updateState();
  }

  void selectPackageVersion(String name, String version) {
    final installedVersion = state.dependencies
            .firstWhereOrNull(
              (packageViewModel) => packageViewModel.name == name,
            )
            ?.installedVersion ??
        state.devDependencies
            .firstWhereOrNull(
              (packageViewModel) => packageViewModel.name == name,
            )
            ?.installedVersion;

    packageVersionsToChange = installedVersion == version
        ? packageVersionsToChange.remove(name)
        : packageVersionsToChange.update(
            name,
            (value) => version,
            ifAbsent: () => version,
          );

    _updateState();
  }

  Future<void> upgradeAllPackages() async {
    packages
        .where(_isNotSdkDependency)
        .whereNot(isPackageLatestVersionInstalled)
        .forEach((package) {
      if (package.resolvableVersion == null) return;
      packageVersionsToChange = packageVersionsToChange.update(
        package.name,
        (value) => package.resolvableVersion!,
        ifAbsent: () => package.resolvableVersion!,
      );
    });

    await _updateState();
  }

  Future<void> applyChanges() async {
    await _applyPackageVersionChangesToProject();
    await reload();
  }

  Future<void> clearChanges() async {
    packageVersionsToChange = <String, String>{}.lock;
    await _updateState();
  }

  Future<void> reload() async {
    packages = [];
    packageVersionsToChange = <String, String>{}.lock;
    await _updateState();

    await _loadProjectPackages();
    await _updateState();
  }

  Future<void> _updateState() async {
    final dependencies = packages
        .where((package) {
          return package.dependencyType == DependencyType.dependency;
        })
        .where(_isNotSdkDependency)
        .where(_applyPackageFilter)
        .map((package) {
          return _createPackageViewModel(
            package,
            packageVersionsToChange,
          );
        })
        .toIList();

    final devDependencies = packages
        .where((package) {
          return package.dependencyType == DependencyType.devDependency;
        })
        .where(_isNotSdkDependency)
        .where(_applyPackageFilter)
        .map((package) {
          return _createPackageViewModel(
            package,
            packageVersionsToChange,
          );
        })
        .toIList();

    emit(
      state.copyWith(
        packageVersionsToChangeCount: packageVersionsToChange.length,
        dependencies: dependencies,
        devDependencies: devDependencies,
      ),
    );
  }

  bool _isNotSdkDependency(Package package) => package.type != PackageType.sdk;

  bool _applyPackageFilter(Package package) {
    switch (state.packageFilter) {
      case PackageFilter.all:
        return true;
      case PackageFilter.upgradable:
        return !isPackageLatestVersionInstalled(package);
    }
  }

  Future<void> _loadProjectPackages() async {
    final projectPath = _projectPath;
    if (projectPath == null || projectPath.isEmpty) return;

    emit(
      state.copyWith(isLoading: true),
    );
    try {
      packages = await Isolate.run(
        () => getPackages(projectPath),
      );
    } catch (exception) {
      print(exception);
    }
    emit(
      state.copyWith(isLoading: false),
    );
  }

  Future<void> _applyPackageVersionChangesToProject() async {
    final projectPath = _projectPath;
    if (projectPath == null || projectPath.isEmpty) return;

    if (packages.isEmpty) return;

    if (packageVersionsToChange.isEmpty) return;
    final packageVersionsToChangeMap = packageVersionsToChange.unlock;

    emit(
      state.copyWith(isLoading: true),
    );
    try {
      await Isolate.run(
        () => applyPackageVersionChanges(
          projectPath,
          packageVersionsToChangeMap,
        ),
      );
    } catch (exception) {
      print(exception);
    }
    emit(
      state.copyWith(isLoading: false),
    );
  }
}
