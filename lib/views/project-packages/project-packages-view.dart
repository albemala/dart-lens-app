import 'package:dart_lens/functions/url.dart';
import 'package:dart_lens/views/project-packages/project-packages-view-conductor.dart';
import 'package:dart_lens/widgets/button.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class ProjectPackagesView extends StatelessWidget {
  const ProjectPackagesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectPackagesViewConductor>(
      create: ProjectPackagesViewConductor.fromContext,
      child: const Column(
        children: [
          Divider(),
          _ActionBarView(),
          Divider(),
          Expanded(
            child: _PackagesView(),
          ),
        ],
      ),
    );
  }
}

class _ActionBarView extends StatelessWidget {
  const _ActionBarView();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectPackagesViewConductor>(
      builder: (context, conductor, child) {
        return Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SeparatedRow(
              children: [
                if (conductor.dependencies.isNotEmpty ||
                    conductor.devDependencies.isNotEmpty)
                  SeparatedRow(
                    children: [
                      PopupMenuButton<PackageFilter>(
                        tooltip: 'Filter packages',
                        icon: const Icon(CupertinoIcons.cube_box),
                        itemBuilder: (context) {
                          return PackageFilter.values.map(
                            (filter) {
                              return PopupMenuItem<PackageFilter>(
                                value: filter,
                                child: Text(filter.title),
                                onTap: () {
                                  conductor.setPackageFilter(filter);
                                },
                              );
                            },
                          ).toList();
                        },
                      ),
                      Text(
                        conductor.packageFilter.title,
                      ),
                    ],
                    separatorBuilder: () => const SizedBox(width: 4),
                  ),
                if (conductor.dependencies.isNotEmpty ||
                    conductor.devDependencies.isNotEmpty)
                  Tooltip(
                    message: 'Select all package upgrades',
                    child: IconButton(
                      onPressed: () {
                        conductor.upgradeAllPackages();
                      },
                      icon: const Icon(CupertinoIcons.arrow_up_to_line),
                    ),
                  ),
                if (conductor.packageVersionsToChangeCount > 0)
                  Row(
                    children: [
                      FilledButton(
                        onPressed: () {
                          conductor.applyChanges();
                        },
                        child: const Text('Apply changes'),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'You have changed ${conductor.packageVersionsToChangeCount} package(s)',
                      ),
                      // button to clear all changes
                      Tooltip(
                        message: 'Clear all changes',
                        child: IconButton(
                          onPressed: () {
                            conductor.clearChanges();
                          },
                          icon: const Icon(CupertinoIcons.clear),
                        ),
                      ),
                    ],
                  ),
                const Spacer(),
                if (conductor.isLoading) //
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                Tooltip(
                  message: 'Reload project',
                  child: IconButton(
                    onPressed: () {
                      conductor.reload();
                    },
                    icon: const Icon(CupertinoIcons.arrow_clockwise),
                  ),
                ),
              ],
              separatorBuilder: () => const SizedBox(width: 16),
            ),
          ),
        );
      },
    );
  }
}

class _PackagesView extends StatelessWidget {
  const _PackagesView();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectPackagesViewConductor>(
      builder: (context, conductor, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Dependencies',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: conductor.dependencies.length,
                  itemBuilder: (context, index) {
                    final dependency = conductor.dependencies[index];
                    return _PackageView(
                      dependency: dependency,
                      onVersionSelected: (version) {
                        conductor.selectPackageVersion(
                          dependency.name,
                          version,
                        );
                      },
                      onLatestVersionSelected: () {
                        conductor.selectPackageVersion(
                          dependency.name,
                          dependency.installableVersion!,
                        );
                      },
                      onClearSelectedVersion: () {
                        conductor.selectPackageVersion(
                          dependency.name,
                          dependency.installedVersion!,
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Dev dependencies',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: conductor.devDependencies.length,
                  itemBuilder: (context, index) {
                    final dependency = conductor.devDependencies[index];
                    return _PackageView(
                      dependency: dependency,
                      onVersionSelected: (version) {
                        conductor.selectPackageVersion(
                          dependency.name,
                          version,
                        );
                      },
                      onLatestVersionSelected: () {
                        conductor.selectPackageVersion(
                          dependency.name,
                          dependency.installableVersion!,
                        );
                      },
                      onClearSelectedVersion: () {
                        conductor.selectPackageVersion(
                          dependency.name,
                          dependency.installedVersion!,
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PackageView extends HookWidget {
  final ProjectPackage dependency;
  final void Function(String version) onVersionSelected;
  final void Function() onLatestVersionSelected;
  final void Function() onClearSelectedVersion;

  const _PackageView({
    required this.dependency,
    required this.onVersionSelected,
    required this.onLatestVersionSelected,
    required this.onClearSelectedVersion,
  });

  @override
  Widget build(BuildContext context) {
    final isHovering = useState(false);

    return MouseRegion(
      onEnter: (_) => isHovering.value = true,
      onExit: (_) => isHovering.value = false,
      child: Material(
        color: isHovering.value
            ? Theme.of(context).colorScheme.surfaceVariant
            : Colors.transparent,
        child: SizedBox(
          height: 48,
          child: Row(
            children: [
              Expanded(
                child: _PackageNameView(dependency: dependency),
              ),
              Expanded(
                flex: 3,
                child: _PackageVersionsView(
                  dependency: dependency,
                  onVersionSelected: onVersionSelected,
                  onLatestVersionSelected: onLatestVersionSelected,
                  onClearSelectedVersion: onClearSelectedVersion,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PackageNameView extends StatelessWidget {
  final ProjectPackage dependency;

  const _PackageNameView({
    required this.dependency,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Tooltip(
            message: dependency.description ?? '',
            child: Text(
              dependency.name,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        // package url
        if (dependency.url != null)
          IconButton(
            tooltip: dependency.url,
            icon: const Icon(CupertinoIcons.arrow_up_right),
            iconSize: 14,
            onPressed: () {
              // TODO use conductor
              openUrl(dependency.url!);
            },
          ),
      ],
    );
  }
}

class _PackageVersionsView extends StatelessWidget {
  final ProjectPackage dependency;
  final void Function(String version) onVersionSelected;
  final void Function() onLatestVersionSelected;
  final void Function() onClearSelectedVersion;

  const _PackageVersionsView({
    required this.dependency,
    required this.onVersionSelected,
    required this.onLatestVersionSelected,
    required this.onClearSelectedVersion,
  });

  @override
  Widget build(BuildContext context) {
    return SeparatedRow(
      children: [
        // changelog
        if (dependency.changelogUrl != null)
          IconButton(
            tooltip: 'Changelog',
            icon: const Icon(CupertinoIcons.doc_text),
            iconSize: 16,
            onPressed: () {
              // TODO use conductor
              openUrl(dependency.changelogUrl!);
            },
          ),
        _VersionSelectorView(
          dependency: dependency,
          onSelected: onVersionSelected,
        ),
        if (!dependency.isLatestVersionInstalled &&
            dependency.installableVersion != null)
          _LatestVersionView(
            dependency: dependency,
            onPressed: onLatestVersionSelected,
          ),
        if (dependency.changeToVersion != null &&
            dependency.installedVersion != null)
          _ChangeToVersionView(
            dependency: dependency,
            onPressed: onClearSelectedVersion,
          ),
      ],
      separatorBuilder: () => const SizedBox(width: 4),
    );
  }
}

class _VersionSelectorView extends StatelessWidget {
  final ProjectPackage dependency;
  final void Function(String version) onSelected;

  const _VersionSelectorView({
    required this.dependency,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final backgroundColor = Theme.of(context).colorScheme.secondaryContainer;
    final textColor = Theme.of(context).colorScheme.onSecondaryContainer;

    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      color: backgroundColor,
      child: PopupMenuButton<String>(
        tooltip: 'Select version',
        initialValue: dependency.installedVersion,
        onSelected: onSelected,
        itemBuilder: (itemBuilderContext) {
          return dependency.availableVersions?.map((version) {
                return PopupMenuItem<String>(
                  value: version.version,
                  child: _VersionMenuItemView(version: version),
                );
              }).toList() ??
              [];
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: SeparatedRow(
            children: [
              Text(
                dependency.installedVersion ?? '',
                style: textStyle?.copyWith(
                  color: textColor,
                ),
              ),
              Icon(
                CupertinoIcons.chevron_down,
                color: textColor,
                size: 12,
              ),
            ],
            separatorBuilder: () => const SizedBox(width: 2),
          ),
        ),
      ),
    );
  }
}

class _VersionMenuItemView extends StatelessWidget {
  final AvailableVersion version;

  const _VersionMenuItemView({
    required this.version,
  });

  @override
  Widget build(BuildContext context) {
    return SeparatedRow(
      children: [
        if (!version.isInstallable)
          Tooltip(
            message: 'Version might not be installable',
            child: Icon(
              CupertinoIcons.exclamationmark_triangle,
              size: 14,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        if (version.isInstalled && !version.willBeUninstalled)
          Tooltip(
            message: 'Version is installed',
            child: Icon(
              CupertinoIcons.arrow_right,
              size: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        if (version.willBeUninstalled)
          Tooltip(
            message: 'Version will be uninstalled',
            child: Icon(
              CupertinoIcons.xmark,
              size: 14,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        if (version.willBeInstalled)
          Tooltip(
            message: 'Version will be installed',
            child: Icon(
              CupertinoIcons.checkmark_alt,
              size: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        Text(version.version),
      ],
      separatorBuilder: () => const SizedBox(width: 4),
    );
  }
}

class _LatestVersionView extends StatelessWidget {
  // TODO pass dependency.installableVersion
  final ProjectPackage dependency;
  final void Function() onPressed;

  const _LatestVersionView({
    required this.dependency,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final backgroundColor = Theme.of(context).colorScheme.primaryContainer;
    final textColor = Theme.of(context).colorScheme.onPrimaryContainer;

    return Tooltip(
      message:
          'Latest version: ${dependency.installableVersion}. Click to select.',
      child: SmallButtonWidget(
        backgroundColor: backgroundColor,
        onPressed: onPressed,
        child: SeparatedRow(
          children: [
            Icon(
              CupertinoIcons.up_arrow,
              color: textColor,
              size: 12,
            ),
            Text(
              dependency.installableVersion!,
              style: textStyle?.copyWith(
                color: textColor,
              ),
            ),
          ],
          separatorBuilder: () => const SizedBox(width: 2),
        ),
      ),
    );
  }
}

class _ChangeToVersionView extends StatelessWidget {
  // TODO pass dependency.changeToVersion
  final ProjectPackage dependency;
  final void Function() onPressed;

  const _ChangeToVersionView({
    required this.dependency,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final backgroundColor = Theme.of(context).colorScheme.secondary;
    final textColor = Theme.of(context).colorScheme.onSecondary;

    return Tooltip(
      message:
          'Change to version: ${dependency.changeToVersion}. Click to reset.',
      child: SmallButtonWidget(
        backgroundColor: backgroundColor,
        onPressed: onPressed,
        child: SeparatedRow(
          children: [
            Icon(
              CupertinoIcons.arrow_2_squarepath,
              color: textColor,
              size: 12,
            ),
            Text(
              dependency.changeToVersion!,
              style: textStyle?.copyWith(
                color: textColor,
              ),
            ),
          ],
          separatorBuilder: () => const SizedBox(width: 2),
        ),
      ),
    );
  }
}
