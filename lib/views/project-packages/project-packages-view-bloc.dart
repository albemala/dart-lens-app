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

@freezed
class ProjectPackagesViewModel with _$ProjectPackagesViewModel {
  const ProjectPackagesViewModel._();

  const factory ProjectPackagesViewModel({
    required bool isLoading,
    required IList<PackageViewModel> dependencies,
    required IList<PackageViewModel> devDependencies,
    required IMap<String, String> packageVersionsToChange,
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
    required bool? isLatestVersionInstalled,
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

PackageViewModel _createPackageViewModel(Package package) {
  final availableVersions = package.availableVersions?.map((availableVersion) {
    return _createPackageVersionViewModel(package, availableVersion);
  }).toIList();
  final isLatestVersionInstalled = isPackageLatestVersionInstalled(package);
  return PackageViewModel(
    name: package.name,
    installedVersion: package.installedVersion,
    installableVersion: package.resolvableVersion,
    changeToVersion: null,
    availableVersions: availableVersions,
    isLatestVersionInstalled: isLatestVersionInstalled,
    url: package.url,
    changelogUrl: package.changelogUrl,
    description: package.description,
  );
}

PackageVersionViewModel _createPackageVersionViewModel(
  Package package,
  PackageVersion availableVersion,
) {
  final isInstallable = isPackageInstallable(package, availableVersion);
  return PackageVersionViewModel(
    version: availableVersion.version,
    isInstalled: availableVersion.version == package.installedVersion,
    isInstallable: isInstallable,
    willBeInstalled: false,
    willBeUninstalled: false,
  );
}

IList<PackageViewModel> _updatePackagesToChangeVersion(
  IList<PackageViewModel> dependencies,
  String name,
  String version,
) {
  return dependencies.map((packageViewModel) {
    final isInstalledVersion = packageViewModel.installedVersion == version;
    if (packageViewModel.name == name) {
      return packageViewModel.copyWith(
        changeToVersion: !isInstalledVersion ? version : null,
        availableVersions: packageViewModel.availableVersions?.map(
          (packageVersionViewModel) {
            return packageVersionViewModel.copyWith(
              willBeInstalled: !isInstalledVersion &&
                  packageVersionViewModel.version == version,
              willBeUninstalled: !isInstalledVersion &&
                  packageVersionViewModel.isInstalled &&
                  packageVersionViewModel.version != version,
            );
          },
        ).toIList(),
      );
    } else {
      return packageViewModel;
    }
  }).toIList();
}

class ProjectPackagesViewBloc extends Cubit<ProjectPackagesViewModel> {
  final BuildContext context;
  late StreamSubscription<ProjectAnalysisBlocState> projectAnalysisBlocListener;

  List<Package> packages = [];

  String? get _projectPath {
    final projectAnalysisBlocState = context.read<ProjectAnalysisBloc>().state;
    return projectAnalysisBlocState.projectPath;
  }

  ProjectPackagesViewBloc(this.context)
      : super(
          ProjectPackagesViewModel(
            isLoading: false,
            dependencies: <PackageViewModel>[].lock,
            devDependencies: <PackageViewModel>[].lock,
            packageVersionsToChange: <String, String>{}.lock,
          ),
        ) {
    projectAnalysisBlocListener = context //
        .read<ProjectAnalysisBloc>()
        .stream
        .listen((projectAnalysisBlocState) {
      emit(
        state.copyWith(
          dependencies: <PackageViewModel>[].lock,
          devDependencies: <PackageViewModel>[].lock,
          packageVersionsToChange: <String, String>{}.lock,
        ),
      );
      _updateState();
    });
    _updateState();
  }

  @override
  Future<void> close() {
    projectAnalysisBlocListener.cancel();
    return super.close();
  }

  void selectPackageVersion(String name, String version) {
    final dependencies = _updatePackagesToChangeVersion(
      state.dependencies,
      name,
      version,
    );

    final devDependencies = _updatePackagesToChangeVersion(
      state.devDependencies,
      name,
      version,
    );

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

    final packageVersionsToChange = installedVersion == version
        ? state.packageVersionsToChange.remove(name)
        : state.packageVersionsToChange.update(
            name,
            (value) => version,
            ifAbsent: () => version,
          );

    emit(
      state.copyWith(
        dependencies: dependencies,
        devDependencies: devDependencies,
        packageVersionsToChange: packageVersionsToChange,
      ),
    );
  }

  Future<void> applyChanges() async {
    await _applyPackageVersionChangesToProject();
    await _updateState();
  }

  void reload() {
    _updateState();
  }

  Future<void> _updateState() async {
    await _loadProjectPackages();

    final dependencies = packages
        .where((package) {
          return package.dependencyType == DependencyType.dependency &&
              // filter out sdk dependencies
              package.type != PackageType.sdk;
        })
        .map(_createPackageViewModel)
        .toIList();

    final devDependencies = packages
        .where((package) {
          return package.dependencyType == DependencyType.devDependency &&
              // filter out sdk dependencies
              package.type != PackageType.sdk;
        })
        .map(_createPackageViewModel)
        .toIList();

    // reset packageVersionsToChange
    final packageVersionsToChange = <String, String>{}.lock;

    emit(
      state.copyWith(
        dependencies: dependencies,
        devDependencies: devDependencies,
        packageVersionsToChange: packageVersionsToChange,
      ),
    );
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

    final packageVersionsToChange = state.packageVersionsToChange.unlock;
    if (packageVersionsToChange.isEmpty) return;

    emit(
      state.copyWith(isLoading: true),
    );
    try {
      await Isolate.run(
        () {
          return applyPackageVersionChanges(
            projectPath,
            packages,
            packageVersionsToChange,
          );
        },
      );
    } catch (exception) {
      print(exception);
    }
    emit(
      state.copyWith(isLoading: false),
    );
  }
}
