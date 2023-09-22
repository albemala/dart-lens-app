import 'package:dart_lens/functions/url.dart';
import 'package:dart_lens/views/project-packages/project-packages-view-conductor.dart';
import 'package:dart_lens/widgets/button.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lucide_icons/lucide_icons.dart';
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
          _ErrorView(),
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
              separatorBuilder: () => const SizedBox(width: 16),
              children: [
                Row(
                  children: [
                    PopupMenuButton<PackageFilter>(
                      tooltip: 'Filter packages',
                      icon: const Icon(LucideIcons.filter),
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
                ),
                Row(
                  children: [
                    Tooltip(
                      message: 'Select all latest versions',
                      child: IconButton(
                        onPressed: () {
                          conductor.selectAllLatestVersions();
                        },
                        icon: const Icon(LucideIcons.arrowUpToLine),
                      ),
                    ),
                  ],
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
                          icon: const Icon(LucideIcons.xCircle),
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
                    icon: const Icon(LucideIcons.rotateCw),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectPackagesViewConductor>(
      builder: (context, conductor, child) {
        return StreamBuilder<String>(
          stream: conductor.errorDialogStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Material(
                color: Theme.of(context).colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          snapshot.data!.trim(),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer,
                                  ),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -10),
                        child: IconButton(
                          onPressed: () {
                            conductor.closeErrorDialog();
                          },
                          icon: const Icon(LucideIcons.x),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
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
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: conductor.dependencies.length,
                  itemBuilder: (context, index) {
                    final dependency = conductor.dependencies[index];
                    return _HoverableListItemView(
                      child: _PackageListItemView(
                        dependency: dependency,
                        onOpenPackageUrl: () {
                          openUrl(dependency.url);
                        },
                        onOpenPackageChangelogUrl: () {
                          openUrl(dependency.changelogUrl);
                        },
                        onVersionSelected: (version) {
                          conductor.selectPackageVersion(
                            dependency.name,
                            version,
                          );
                        },
                        onLatestVersionSelected: () {
                          conductor.selectPackageVersion(
                            dependency.name,
                            dependency.latestVersion,
                          );
                        },
                        onClearSelectedVersion: () {
                          conductor.selectPackageVersion(
                            dependency.name,
                            dependency.installedVersion,
                          );
                        },
                      ),
                    );
                  },
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
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: conductor.devDependencies.length,
                  itemBuilder: (context, index) {
                    final dependency = conductor.devDependencies[index];
                    return _HoverableListItemView(
                      child: _PackageListItemView(
                        dependency: dependency,
                        onOpenPackageUrl: () {
                          openUrl(dependency.url);
                        },
                        onOpenPackageChangelogUrl: () {
                          openUrl(dependency.changelogUrl);
                        },
                        onVersionSelected: (version) {
                          conductor.selectPackageVersion(
                            dependency.name,
                            version,
                          );
                        },
                        onLatestVersionSelected: () {
                          conductor.selectPackageVersion(
                            dependency.name,
                            dependency.latestVersion,
                          );
                        },
                        onClearSelectedVersion: () {
                          conductor.selectPackageVersion(
                            dependency.name,
                            dependency.installedVersion,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HoverableListItemView extends HookWidget {
  final Widget child;

  const _HoverableListItemView({
    required this.child,
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
          child: child,
        ),
      ),
    );
  }
}

class _PackageListItemView extends StatelessWidget {
  final ProjectPackage dependency;
  final void Function() onOpenPackageUrl;
  final void Function() onOpenPackageChangelogUrl;
  final void Function(String version) onVersionSelected;
  final void Function() onLatestVersionSelected;
  final void Function() onClearSelectedVersion;

  const _PackageListItemView({
    required this.dependency,
    required this.onOpenPackageUrl,
    required this.onOpenPackageChangelogUrl,
    required this.onVersionSelected,
    required this.onLatestVersionSelected,
    required this.onClearSelectedVersion,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // name
        SizedBox(
          width: 240,
          child: Tooltip(
            message: dependency.description,
            child: Text(
              dependency.name,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        // url
        if (dependency.url.isNotEmpty)
          IconButton(
            tooltip: dependency.url,
            icon: const Icon(LucideIcons.externalLink),
            iconSize: 14,
            onPressed: onOpenPackageUrl,
          ),
        // changelog
        if (dependency.changelogUrl.isNotEmpty)
          IconButton(
            tooltip: 'Changelog',
            icon: const Icon(LucideIcons.fileText),
            iconSize: 16,
            onPressed: onOpenPackageChangelogUrl,
          ),
        const SizedBox(width: 8),
        // availableVersions
        SizedBox(
          width: 96,
          child: UnconstrainedBox(
            alignment: Alignment.centerLeft,
            child: dependency.availableVersions.isNotEmpty
                ? _VersionSelectorView(
                    dependency: dependency,
                    onSelected: onVersionSelected,
                  )
                : Container(),
          ),
        ),
        // latestVersion
        SizedBox(
          width: 96,
          child: UnconstrainedBox(
            alignment: Alignment.centerLeft,
            child: SeparatedRow(
              separatorBuilder: () => const SizedBox(width: 8),
              children: [
                if (dependency.latestVersion.isNotEmpty)
                  _LatestVersionView(
                    latestVersion: dependency.latestVersion,
                    onPressed: onLatestVersionSelected,
                  ),
                if (dependency.isVersionWarningVisible)
                  Tooltip(
                    message: 'Version might not be installable',
                    child: Icon(
                      LucideIcons.alertTriangle,
                      size: 14,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
              ],
            ),
          ),
        ),
        // versionToInstall
        SizedBox(
          width: 96,
          child: UnconstrainedBox(
            alignment: Alignment.centerLeft,
            child: dependency.versionToInstall.isNotEmpty
                ? _VersionToInstallView(
                    versionToInstall: dependency.versionToInstall,
                    onPressed: onClearSelectedVersion,
                  )
                : Container(),
          ),
        ),
      ],
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
          return dependency.availableVersions.map((version) {
            return PopupMenuItem<String>(
              value: version.version,
              child: _VersionMenuItemView(version: version),
            );
          }).toList();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: SeparatedRow(
            separatorBuilder: () => const SizedBox(width: 2),
            children: [
              Text(
                dependency.installedVersion,
                style: textStyle?.copyWith(
                  color: textColor,
                ),
              ),
              Icon(
                LucideIcons.chevronDown,
                color: textColor,
                size: 12,
              ),
            ],
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
      separatorBuilder: () => const SizedBox(width: 4),
      children: [
        if (!version.isInstallable)
          Tooltip(
            message: 'Version might not be installable',
            child: Icon(
              LucideIcons.alertTriangle,
              size: 14,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        if (version.isInstalled && !version.willBeUninstalled)
          Tooltip(
            message: 'Version is installed',
            child: Icon(
              LucideIcons.arrowRight,
              size: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        if (version.willBeUninstalled)
          Tooltip(
            message: 'Version will be uninstalled',
            child: Icon(
              LucideIcons.x,
              size: 14,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        if (version.willBeInstalled)
          Tooltip(
            message: 'Version will be installed',
            child: Icon(
              LucideIcons.check,
              size: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        Text(version.version),
      ],
    );
  }
}

class _LatestVersionView extends StatelessWidget {
  final String latestVersion;
  final void Function() onPressed;

  const _LatestVersionView({
    required this.latestVersion,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final backgroundColor = Theme.of(context).colorScheme.primaryContainer;
    final textColor = Theme.of(context).colorScheme.onPrimaryContainer;

    return SmallButtonWidget(
      tooltip: 'Latest version: $latestVersion. Click to select.',
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      child: SeparatedRow(
        mainAxisSize: MainAxisSize.min,
        separatorBuilder: () => const SizedBox(width: 2),
        children: [
          Icon(
            LucideIcons.arrowUp,
            color: textColor,
            size: 12,
          ),
          Text(
            latestVersion,
            style: textStyle?.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _VersionToInstallView extends StatelessWidget {
  final String versionToInstall;
  final void Function() onPressed;

  const _VersionToInstallView({
    required this.versionToInstall,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final backgroundColor = Theme.of(context).colorScheme.secondary;
    final textColor = Theme.of(context).colorScheme.onSecondary;

    return SmallButtonWidget(
      tooltip: 'Version to install: $versionToInstall. Click to reset.',
      backgroundColor: backgroundColor,
      onPressed: onPressed,
      child: SeparatedRow(
        mainAxisSize: MainAxisSize.min,
        separatorBuilder: () => const SizedBox(width: 2),
        children: [
          Icon(
            LucideIcons.repeat2,
            color: textColor,
            size: 12,
          ),
          Text(
            versionToInstall,
            style: textStyle?.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
