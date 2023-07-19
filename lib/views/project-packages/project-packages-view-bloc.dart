import 'dart:async';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:dart_lens/blocs/bloc-value.dart';
import 'package:dart_lens/blocs/project-analysis-bloc.dart';
import 'package:dart_lens/functions/installed-packages.dart';
import 'package:dart_lens/functions/packages.dart';
import 'package:dart_lens/functions/project-packages-analysis.dart';
import 'package:dart_lens/models/package/package.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pub_api_client/pub_api_client.dart';

enum PackageFilter {
  all(title: 'All'),
  upgradable(title: 'Upgradable');

  final String title;

  const PackageFilter({
    required this.title,
  });
}

@immutable
class ProjectPackagesViewModel extends Equatable {
  final bool isLoading;
  final PackageFilter packageFilter;
  final int packageVersionsToChangeCount;
  final List<PackageViewModel> dependencies;
  final List<PackageViewModel> devDependencies;

  const ProjectPackagesViewModel({
    required this.isLoading,
    required this.packageFilter,
    required this.packageVersionsToChangeCount,
    required this.dependencies,
    required this.devDependencies,
  });

  @override
  List<Object?> get props => [
        isLoading,
        packageFilter,
        packageVersionsToChangeCount,
        dependencies,
        devDependencies,
      ];
}

@immutable
class PackageViewModel extends Equatable {
  final String name;
  final String? installedVersion;
  final String? installableVersion;
  final String? changeToVersion;
  final List<PackageVersionViewModel>? availableVersions;
  final bool isLatestVersionInstalled;
  final String? url;
  final String? changelogUrl;
  final String? description;

  const PackageViewModel({
    required this.name,
    required this.installedVersion,
    required this.installableVersion,
    required this.changeToVersion,
    required this.availableVersions,
    required this.isLatestVersionInstalled,
    required this.url,
    required this.changelogUrl,
    required this.description,
  });

  @override
  List<Object?> get props => [
        name,
        installedVersion,
        installableVersion,
        changeToVersion,
        availableVersions,
        isLatestVersionInstalled,
        url,
        changelogUrl,
        description,
      ];
}

@immutable
class PackageVersionViewModel extends Equatable {
  final String version;
  final bool isInstalled;
  final bool isInstallable;
  final bool willBeInstalled;
  final bool willBeUninstalled;

  const PackageVersionViewModel({
    required this.version,
    required this.isInstalled,
    required this.isInstallable,
    required this.willBeInstalled,
    required this.willBeUninstalled,
  });

  @override
  List<Object?> get props => [
        version,
        isInstalled,
        isInstallable,
        willBeInstalled,
        willBeUninstalled,
      ];
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
  }).toList();
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

const _defaultPackageFilter = PackageFilter.all;

class ProjectPackagesViewBloc extends Cubit<ProjectPackagesViewModel> {
  factory ProjectPackagesViewBloc.fromContext(BuildContext context) {
    return ProjectPackagesViewBloc._(
      context.read<ProjectAnalysisBloc>(),
    );
  }

  final ProjectAnalysisBloc _projectAnalysisBloc;

  late final StreamSubscription<ProjectAnalysisBlocState>
      _projectAnalysisBlocListener;

  late final BlocValue<bool> _isLoading;
  late final BlocValue<PackageFilter> _packageFilter;
  late final BlocValue<IMap<String, String>> _packageVersionsToChange;

  IList<Package> _packages = const <Package>[].lock;

  String get _projectPath {
    return _projectAnalysisBloc.state.projectPath ?? '';
  }

  ProjectPackagesViewBloc._(
    this._projectAnalysisBloc,
  ) : super(
          const ProjectPackagesViewModel(
            isLoading: false,
            packageFilter: _defaultPackageFilter,
            packageVersionsToChangeCount: 0,
            dependencies: <PackageViewModel>[],
            devDependencies: <PackageViewModel>[],
          ),
        ) {
    _isLoading = BlocValue<bool>(
      initialValue: false,
      onChange: _updateState,
    );
    _packageFilter = BlocValue(
      initialValue: _defaultPackageFilter,
      onChange: _updateState,
    );
    _packageVersionsToChange = BlocValue(
      initialValue: <String, String>{}.lock,
      onChange: _updateState,
    );
    _projectAnalysisBlocListener =
        _projectAnalysisBloc.stream.listen((projectAnalysisBlocState) {
      reload();
    });
    reload();
  }

  @override
  Future<void> close() {
    _isLoading.dispose();
    _packageFilter.dispose();
    _packageVersionsToChange.dispose();
    _projectAnalysisBlocListener.cancel();
    return super.close();
  }

  void setPackageFilter(PackageFilter filter) {
    _packageFilter.value = filter;
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

    _packageVersionsToChange.value = installedVersion == version
        ? _packageVersionsToChange.value.remove(name)
        : _packageVersionsToChange.value.update(
            name,
            (value) => version,
            ifAbsent: () => version,
          );
  }

  Future<void> upgradeAllPackages() async {
    _packageVersionsToChange.value = IMap.fromEntries(
      _packages
          .where(_isNotSdkDependency)
          .whereNot(isPackageLatestVersionInstalled)
          .map((package) {
        return MapEntry(
          package.name,
          package.resolvableVersion!,
        );
      }),
    );
  }

  Future<void> applyChanges() async {
    await _applyPackageVersionChangesToProject();
    await reload();
  }

  Future<void> clearChanges() async {
    _packageVersionsToChange.value = <String, String>{}.lock;
  }

  Future<void> reload() async {
    _packages = const <Package>[].lock;
    _packageVersionsToChange.value = <String, String>{}.lock;
    await _loadProjectPackages();
  }

  Future<void> _updateState() async {
    final dependencies = _packages
        .where((package) {
          return package.dependencyType == DependencyType.dependency;
        })
        .where(_isNotSdkDependency)
        .where(_applyPackageFilter)
        .map((package) {
          return _createPackageViewModel(
            package,
            _packageVersionsToChange.value,
          );
        })
        .toList();

    final devDependencies = _packages
        .where((package) {
          return package.dependencyType == DependencyType.devDependency;
        })
        .where(_isNotSdkDependency)
        .where(_applyPackageFilter)
        .map((package) {
          return _createPackageViewModel(
            package,
            _packageVersionsToChange.value,
          );
        })
        .toList();

    emit(
      ProjectPackagesViewModel(
        isLoading: _isLoading.value,
        packageFilter: _packageFilter.value,
        packageVersionsToChangeCount: _packageVersionsToChange.value.length,
        dependencies: dependencies,
        devDependencies: devDependencies,
      ),
    );
  }

  bool _isNotSdkDependency(Package package) => package.type != PackageType.sdk;

  bool _applyPackageFilter(Package package) {
    switch (_packageFilter.value) {
      case PackageFilter.all:
        return true;
      case PackageFilter.upgradable:
        return !isPackageLatestVersionInstalled(package);
    }
  }

  Future<void> _loadProjectPackages() async {
    if (_projectPath.isEmpty) return;

    _isLoading.value = true;
    try {
      final projectPath = _projectPath;
      _packages = IList(
        await Isolate.run(() {
          return getPackages(projectPath);
        }),
      );
    } catch (exception) {
      print(exception);
    }
    _isLoading.value = false;
  }

  Future<void> _applyPackageVersionChangesToProject() async {
    if (_packages.isEmpty) return;
    if (_projectPath.isEmpty) return;
    if (_packageVersionsToChange.value.isEmpty) return;

    _isLoading.value = true;
    try {
      final projectPath = _projectPath;
      final versionsToChange = _packageVersionsToChange.value.unlock;
      await Isolate.run(() {
        return applyPackageVersionChanges(
          projectPath,
          versionsToChange,
        );
      });
    } catch (exception) {
      print(exception);
    }
    _isLoading.value = false;
  }
}
