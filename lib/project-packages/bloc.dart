import 'dart:async';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:dart_lens/preferences/bloc.dart';
import 'package:dart_lens/project-analysis/bloc.dart';
import 'package:dart_lens/project-packages/installed-packages.dart';
import 'package:dart_lens/project-packages/package.dart';
import 'package:dart_lens/project-packages/packages.dart';
import 'package:dart_lens/project-packages/project-packages-analysis.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PackageFilter {
  all(title: 'All'),
  upgradable(title: 'Upgradable');

  final String title;

  const PackageFilter({
    required this.title,
  });
}

@immutable
class AvailableVersion extends Equatable {
  final String version;
  final bool isInstalled;
  final bool isInstallable;
  final bool willBeInstalled;
  final bool willBeUninstalled;

  const AvailableVersion({
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

@immutable
class ProjectPackage extends Equatable {
  final String name;
  final List<AvailableVersion> availableVersions;
  final String installedVersion;
  final String latestVersion;
  final String versionToInstall;
  final bool isVersionWarningVisible;
  final String url;
  final String changelogUrl;
  final String description;

  const ProjectPackage({
    required this.name,
    required this.availableVersions,
    required this.installedVersion,
    required this.latestVersion,
    required this.versionToInstall,
    required this.isVersionWarningVisible,
    required this.url,
    required this.changelogUrl,
    required this.description,
  });

  @override
  List<Object?> get props => [
        name,
        availableVersions,
        installedVersion,
        latestVersion,
        versionToInstall,
        isVersionWarningVisible,
        url,
        changelogUrl,
        description,
      ];
}

@immutable
class ProjectPackagesViewModel extends Equatable {
  final bool isLoading;
  final PackageFilter packageFilter;
  final int packageVersionsToChangeCount;
  final List<ProjectPackage> dependencies;
  final List<ProjectPackage> devDependencies;
  final String errorMessage;

  const ProjectPackagesViewModel({
    required this.isLoading,
    required this.packageFilter,
    required this.packageVersionsToChangeCount,
    required this.dependencies,
    required this.devDependencies,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [
        isLoading,
        packageFilter,
        packageVersionsToChangeCount,
        dependencies,
        devDependencies,
        errorMessage,
      ];
}

class ProjectPackagesViewBloc extends Cubit<ProjectPackagesViewModel> {
  final PreferencesBloc _preferencesBloc;
  final ProjectAnalysisBloc _projectAnalysisBloc;
  StreamSubscription<ProjectAnalysisState>? _projectAnalysisBlocSubscription;

  bool _isLoading = false;
  List<Package> _packages = <Package>[];
  PackageFilter _packageFilter = PackageFilter.all;
  Map<String, String> _packageVersionsToChange = <String, String>{};
  String _errorMessage = '';

  String get _projectPath => _projectAnalysisBloc.state.projectPath;

  factory ProjectPackagesViewBloc.fromContext(BuildContext context) {
    return ProjectPackagesViewBloc(
      context.read<PreferencesBloc>(),
      context.read<ProjectAnalysisBloc>(),
    );
  }

  ProjectPackagesViewBloc(
    this._preferencesBloc,
    this._projectAnalysisBloc,
  ) : super(
          const ProjectPackagesViewModel(
            isLoading: false,
            packageFilter: PackageFilter.all,
            packageVersionsToChangeCount: 0,
            dependencies: <ProjectPackage>[],
            devDependencies: <ProjectPackage>[],
            errorMessage: '',
          ),
        ) {
    _projectAnalysisBlocSubscription = _projectAnalysisBloc.stream.listen((_) {
      reload();
    });
    reload();
  }

  @override
  Future<void> close() async {
    await _projectAnalysisBlocSubscription?.cancel();
    await super.close();
  }

  void setPackageFilter(PackageFilter filter) {
    _packageFilter = filter;
    _updateViewModel();
  }

  void selectPackageVersion(String name, String version) {
    final installedVersion = _getDependencies()
            .firstWhereOrNull(
              (packageViewModel) => packageViewModel.name == name,
            )
            ?.installedVersion ??
        _getDevDependencies()
            .firstWhereOrNull(
              (packageViewModel) => packageViewModel.name == name,
            )
            ?.installedVersion;

    installedVersion == version
        ? _packageVersionsToChange.remove(name)
        : _packageVersionsToChange.update(
            name,
            (value) => version,
            ifAbsent: () => version,
          );
    _updateViewModel();
  }

  void selectAllLatestVersions() {
    _packageVersionsToChange = Map.fromEntries(
      _packages
          .where(_isNotSdkDependency) //
          .where((package) {
        return package.installedVersion != package.latestVersion;
      }).where((package) {
        return package.latestVersion != null;
      }).map((package) {
        return MapEntry(
          package.name,
          package.latestVersion!,
        );
      }),
    );
    _updateViewModel();
  }

  Future<void> applyChanges() async {
    _isLoading = true;
    _updateViewModel();

    String? errorMessage;
    try {
      await _applyPackageVersionChangesToProject();
    } catch (exception) {
      if (kDebugMode) print(exception);
      errorMessage = exception.toString();
    }

    _isLoading = false;
    _updateViewModel();

    if (errorMessage == null) {
      await reload();
    } else {
      _errorMessage = errorMessage.trim();
      _updateViewModel();
    }
  }

  Future<void> clearChanges() async {
    _packageVersionsToChange = <String, String>{};
    _updateViewModel();
  }

  Future<void> reload() async {
    _packages = <Package>[];
    _packageVersionsToChange = <String, String>{};
    _updateViewModel();

    _isLoading = true;
    _updateViewModel();

    try {
      await _loadProjectPackages();
    } catch (exception) {
      if (kDebugMode) print(exception);
    }

    _isLoading = false;
    _updateViewModel();
  }

  void clearErrorMessage() {
    _errorMessage = '';
    _updateViewModel();
  }

  bool _isNotSdkDependency(Package package) => package.type != PackageType.sdk;

  bool _applyPackageFilter(Package package) {
    switch (_packageFilter) {
      case PackageFilter.all:
        return true;
      case PackageFilter.upgradable:
        return !isPackageLatestVersionInstalled(package);
    }
  }

  Future<void> _loadProjectPackages() async {
    if (_projectPath.isEmpty) return;

    final flutterBinaryPath = _preferencesBloc.state.flutterBinaryPath;
    final projectPath = _projectPath;
    _packages = await Isolate.run(() {
      return getPackages(
        flutterBinaryPath: flutterBinaryPath,
        projectDirectoryPath: projectPath,
      );
    });
    _updateViewModel();
  }

  Future<void> _applyPackageVersionChangesToProject() async {
    if (_packages.isEmpty) return;
    if (_projectPath.isEmpty) return;
    if (_packageVersionsToChange.isEmpty) return;

    final flutterBinaryPath = _preferencesBloc.state.flutterBinaryPath;
    final projectPath = _projectPath;
    final versionsToChange = _packageVersionsToChange;
    await Isolate.run(() {
      return applyPackageVersionChanges(
        flutterBinaryPath: flutterBinaryPath,
        projectDirectoryPath: projectPath,
        packageVersionsToChange: versionsToChange,
      );
    });
  }

  void _updateViewModel() {
    emit(
      ProjectPackagesViewModel(
        isLoading: _isLoading,
        packageFilter: _packageFilter,
        packageVersionsToChangeCount: _packageVersionsToChange.length,
        dependencies: _getDependencies(),
        devDependencies: _getDevDependencies(),
        errorMessage: _errorMessage,
      ),
    );
  }

  List<ProjectPackage> _getDependencies() => _packages
      .where((package) {
        return package.dependencyType == DependencyType.dependency;
      })
      .where(_isNotSdkDependency)
      .where(_applyPackageFilter)
      .map((package) {
        return _createProjectPackage(
          package,
          _packageVersionsToChange,
        );
      })
      .toList();

  List<ProjectPackage> _getDevDependencies() => _packages
      .where((package) {
        return package.dependencyType == DependencyType.devDependency;
      })
      .where(_isNotSdkDependency)
      .where(_applyPackageFilter)
      .map((package) {
        return _createProjectPackage(
          package,
          _packageVersionsToChange,
        );
      })
      .toList();
}

ProjectPackage _createProjectPackage(
  Package package,
  Map<String, String> packageVersionsToChange,
) {
  final versionToInstall = packageVersionsToChange[package.name];
  final availableVersions = package.type == PackageType.hosted //
      ? package.availableVersions?.map((availableVersion) {
          return _createAvailableVersion(
            package,
            availableVersion,
            versionToInstall,
          );
        }).toList()
      : null;
  final installedVersion = package.type == PackageType.hosted //
      ? package.installedVersion
      : null;
  final latestVersion = package.installedVersion != package.latestVersion //
      ? package.latestVersion
      : null;
  final isVersionWarningVisible =
      package.resolvableVersion != package.latestVersion;
  return ProjectPackage(
    name: package.name,
    availableVersions: availableVersions ?? const <AvailableVersion>[],
    installedVersion: installedVersion ?? '',
    latestVersion: latestVersion ?? '',
    versionToInstall: versionToInstall ?? '',
    isVersionWarningVisible: isVersionWarningVisible,
    url: package.url ?? '',
    changelogUrl: package.changelogUrl ?? '',
    description: package.description ?? '',
  );
}

AvailableVersion _createAvailableVersion(
  Package package,
  String availableVersion,
  String? versionToInstall,
) {
  final isInstalled = package.installedVersion == availableVersion;
  return AvailableVersion(
    version: availableVersion,
    isInstalled: isInstalled,
    isInstallable: isPackageInstallable(package, availableVersion),
    willBeInstalled: !isInstalled &&
        versionToInstall != null &&
        versionToInstall == availableVersion,
    willBeUninstalled: isInstalled &&
        versionToInstall != null &&
        versionToInstall != availableVersion,
  );
}
