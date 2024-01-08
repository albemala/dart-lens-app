import 'package:dart_lens/project-packages/package.dart';
import 'package:pub_semver/pub_semver.dart';

bool isPackageInstallable(
  Package package,
  String availableVersion,
) {
  try {
    final resolvableVersion = package.resolvableVersion ?? '';
    return Version.parse(availableVersion) <= Version.parse(resolvableVersion);
  } catch (_) {
    return false;
  }
}

bool isPackageLatestVersionInstalled(Package package) {
  return package.installedVersion == package.resolvableVersion;
}
