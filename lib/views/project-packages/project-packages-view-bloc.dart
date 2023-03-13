import 'dart:async';

import 'package:dart_lens/blocs/project-analysis-bloc.dart';
import 'package:dart_lens/models/package/package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_api_client/pub_api_client.dart';
import 'package:pub_semver/pub_semver.dart';

part 'project-packages-view-bloc.freezed.dart';

@freezed
class ProjectPackagesViewModel with _$ProjectPackagesViewModel {
  const ProjectPackagesViewModel._();

  const factory ProjectPackagesViewModel({
    required List<PackageViewModel> dependencies,
    required List<PackageViewModel> devDependencies,
  }) = _ProjectPackagesViewModel;
}

@freezed
class PackageViewModel with _$PackageViewModel {
  const PackageViewModel._();

  const factory PackageViewModel({
    required String name,
    required String? installedVersion,
    required String? installableVersion,
    required List<PackageVersionViewModel>? availableVersions,
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
  }) = _PackageVersionViewModel;
}

PackageViewModel _createPackageViewModel(Package package) {
  final availableVersions = package.availableVersions?.map((availableVersion) {
    return _createPackageVersionViewModel(package, availableVersion);
  }).toList();
  final isLatestVersionInstalled =
      package.installedVersion == package.latestVersion?.version;
  return PackageViewModel(
    name: package.name,
    installedVersion: package.installedVersion,
    installableVersion: package.resolvableVersion,
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
  final isInstallable = _isPackageInstallable(package, availableVersion);
  return PackageVersionViewModel(
    version: availableVersion.version,
    isInstalled: availableVersion.version == package.installedVersion,
    isInstallable: isInstallable,
  );
}

bool _isPackageInstallable(
  Package package,
  PackageVersion availableVersion,
) {
  try {
    return Version.parse(availableVersion.version) <=
        Version.parse(package.resolvableVersion ?? '');
  } catch (e) {
    return false;
  }
}

class ProjectPackagesViewBloc extends Cubit<ProjectPackagesViewModel> {
  late StreamSubscription<ProjectAnalysisBlocState> projectAnalysisBlocListener;

  ProjectPackagesViewBloc(BuildContext context)
      : super(
          const ProjectPackagesViewModel(
            dependencies: [],
            devDependencies: [],
          ),
        ) {
    projectAnalysisBlocListener = context //
        .read<ProjectAnalysisBloc>()
        .stream
        .listen((projectAnalysisBlocState) {
      final dependencies = projectAnalysisBlocState.packages
              ?.where((package) {
                return package.dependencyType == DependencyType.dependency &&
                    // filter out sdk dependencies
                    package.type != PackageType.sdk;
              })
              .map(_createPackageViewModel)
              .toList() ??
          [];
      final devDependencies = projectAnalysisBlocState.packages
              ?.where((package) {
                return package.dependencyType == DependencyType.devDependency &&
                    // filter out sdk dependencies
                    package.type != PackageType.sdk;
              })
              .map(_createPackageViewModel)
              .toList() ??
          [];
      emit(
        state.copyWith(
          dependencies: dependencies,
          devDependencies: devDependencies,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    projectAnalysisBlocListener.cancel();
    return super.close();
  }
}
