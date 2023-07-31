import 'dart:async';
import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:dart_lens/conductors/project-analysis-conductor.dart';
import 'package:dart_lens/functions/installed-packages.dart';
import 'package:dart_lens/functions/packages.dart';
import 'package:dart_lens/functions/project-packages-analysis.dart';
import 'package:dart_lens/models/package/package.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum PackageFilter {
  all(title: 'All'),
  upgradable(title: 'Upgradable');

  final String title;

  const PackageFilter({
    required this.title,
  });
}

@immutable
class ProjectPackage {
  final String name;
  final String? installedVersion;
  final String? installableVersion;
  final String? changeToVersion;
  final List<AvailableVersion>? availableVersions;
  final bool isLatestVersionInstalled;
  final String? url;
  final String? changelogUrl;
  final String? description;

  const ProjectPackage({
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
}

@immutable
class AvailableVersion {
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
}

ProjectPackage _createProjectPackage(
  Package package,
  IMap<String, String> packageVersionsToChange,
) {
  final changeToVersion = packageVersionsToChange[package.name];
  final availableVersions = package.availableVersions?.map((availableVersion) {
    return _createAvailableVersion(
      package,
      availableVersion,
      changeToVersion,
    );
  }).toList();
  return ProjectPackage(
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

AvailableVersion _createAvailableVersion(
  Package package,
  String availableVersion,
  String? changeToVersion,
) {
  final isInstalled = package.installedVersion == availableVersion;
  return AvailableVersion(
    version: availableVersion,
    isInstalled: isInstalled,
    isInstallable: isPackageInstallable(package, availableVersion),
    willBeInstalled: !isInstalled &&
        changeToVersion != null &&
        changeToVersion == availableVersion,
    willBeUninstalled: isInstalled &&
        changeToVersion != null &&
        changeToVersion != availableVersion,
  );
}

class ProjectPackagesViewConductor extends ChangeNotifier {
  factory ProjectPackagesViewConductor.fromContext(BuildContext context) {
    return ProjectPackagesViewConductor(
      context.read<ProjectAnalysisConductor>(),
    );
  }

  final ProjectAnalysisConductor _projectAnalysisConductor;

  bool _isLoading = false;
  PackageFilter _packageFilter = PackageFilter.all;
  IMap<String, String> _packageVersionsToChange = <String, String>{}.lock;

  IList<Package> _packages = const <Package>[].lock;

  bool get isLoading => _isLoading;

  PackageFilter get packageFilter => _packageFilter;

  int get packageVersionsToChangeCount => _packageVersionsToChange.length;

  String get _projectPath => _projectAnalysisConductor.projectPath;

  List<ProjectPackage> get dependencies => _packages
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

  List<ProjectPackage> get devDependencies => _packages
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

  ProjectPackagesViewConductor(
    this._projectAnalysisConductor,
  ) {
    _projectAnalysisConductor.addListener(reload);
    reload();
  }

  @override
  void dispose() {
    _projectAnalysisConductor.removeListener(reload);
    super.dispose();
  }

  void setPackageFilter(PackageFilter filter) {
    _packageFilter = filter;
    notifyListeners();
  }

  void selectPackageVersion(String name, String version) {
    final installedVersion = dependencies
            .firstWhereOrNull(
              (packageViewModel) => packageViewModel.name == name,
            )
            ?.installedVersion ??
        devDependencies
            .firstWhereOrNull(
              (packageViewModel) => packageViewModel.name == name,
            )
            ?.installedVersion;

    _packageVersionsToChange = installedVersion == version
        ? _packageVersionsToChange.remove(name)
        : _packageVersionsToChange.update(
            name,
            (value) => version,
            ifAbsent: () => version,
          );
    notifyListeners();
  }

  Future<void> upgradeAllPackages() async {
    _packageVersionsToChange = IMap.fromEntries(
      _packages
          .where(_isNotSdkDependency)
          .whereNot(isPackageLatestVersionInstalled)
          .where((package) => package.resolvableVersion != null)
          .map((package) {
        return MapEntry(
          package.name,
          package.resolvableVersion!,
        );
      }),
    );
    notifyListeners();
  }

  Future<void> applyChanges() async {
    await _applyPackageVersionChangesToProject();
    await reload();
  }

  Future<void> clearChanges() async {
    _packageVersionsToChange = <String, String>{}.lock;
    notifyListeners();
  }

  Future<void> reload() async {
    _packages = const <Package>[].lock;
    _packageVersionsToChange = <String, String>{}.lock;
    notifyListeners();

    await _loadProjectPackages();
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

    _isLoading = true;
    notifyListeners();
    try {
      final projectPath = _projectPath;
      _packages = IList(
        await Isolate.run(() {
          return getPackages(projectPath);
        }),
      );
      notifyListeners();
    } catch (exception) {
      print(exception);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _applyPackageVersionChangesToProject() async {
    if (_packages.isEmpty) return;
    if (_projectPath.isEmpty) return;
    if (_packageVersionsToChange.isEmpty) return;

    _isLoading = true;
    notifyListeners();
    try {
      final projectPath = _projectPath;
      final versionsToChange = _packageVersionsToChange.unlock;
      await Isolate.run(() {
        return applyPackageVersionChanges(
          projectPath,
          versionsToChange,
        );
      });
    } catch (exception) {
      print(exception);
    }
    _isLoading = false;
    notifyListeners();
  }
}
