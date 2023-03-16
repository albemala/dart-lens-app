import 'package:dart_lens/models/package/package.dart';
import 'package:pub_api_client/pub_api_client.dart';
import 'package:pub_semver/pub_semver.dart';

bool isPackageInstallable(
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

bool isPackageLatestVersionInstalled(Package package) {
  return package.installedVersion == package.resolvableVersion;
}
