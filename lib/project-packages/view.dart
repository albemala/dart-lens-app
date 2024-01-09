import 'package:dart_lens/project-packages/bloc.dart';
import 'package:dart_lens/urls/functions.dart';
import 'package:dart_lens/widgets/button.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProjectPackagesViewBuilder extends StatelessWidget {
  const ProjectPackagesViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectPackagesViewBloc>(
      create: ProjectPackagesViewBloc.fromContext,
      child: BlocBuilder<ProjectPackagesViewBloc, ProjectPackagesViewModel>(
        builder: (context, viewModel) {
          return ProjectPackagesView(
            bloc: context.read<ProjectPackagesViewBloc>(),
            viewModel: viewModel,
          );
        },
      ),
    );
  }
}

class ProjectPackagesView extends StatelessWidget {
  final ProjectPackagesViewBloc bloc;
  final ProjectPackagesViewModel viewModel;

  const ProjectPackagesView({
    super.key,
    required this.bloc,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        _ActionBarView(
          packageFilter: viewModel.packageFilter,
          packageVersionsToChangeCount: viewModel.packageVersionsToChangeCount,
          isLoading: viewModel.isLoading,
          onSetPackageFilter: bloc.setPackageFilter,
          onSelectAllLatestVersions: bloc.selectAllLatestVersions,
          onApplyChanges: bloc.applyChanges,
          onClearChanges: bloc.clearChanges,
          onReload: bloc.reload,
        ),
        const Divider(),
        if (viewModel.errorMessage.isNotEmpty) //
          _ErrorView(
            errorMessage: viewModel.errorMessage,
            onClose: bloc.clearErrorMessage,
          ),
        Expanded(
          child: _PackagesView(
            dependencies: viewModel.dependencies,
            devDependencies: viewModel.devDependencies,
            onSelectPackageVersion: bloc.selectPackageVersion,
            onOpenPackageUrl: openUrl,
            onOpenPackageChangelogUrl: openUrl,
          ),
        ),
      ],
    );
  }
}

class _ActionBarView extends StatelessWidget {
  final PackageFilter packageFilter;
  final int packageVersionsToChangeCount;
  final bool isLoading;
  final void Function(PackageFilter) onSetPackageFilter;
  final void Function() onSelectAllLatestVersions;
  final void Function() onApplyChanges;
  final void Function() onClearChanges;
  final void Function() onReload;

  const _ActionBarView({
    required this.packageFilter,
    required this.packageVersionsToChangeCount,
    required this.isLoading,
    required this.onSetPackageFilter,
    required this.onSelectAllLatestVersions,
    required this.onApplyChanges,
    required this.onClearChanges,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
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
                            onSetPackageFilter(filter);
                          },
                        );
                      },
                    ).toList();
                  },
                ),
                Text(
                  packageFilter.title,
                ),
              ],
            ),
            Row(
              children: [
                Tooltip(
                  message: 'Select all latest versions',
                  child: IconButton(
                    onPressed: onSelectAllLatestVersions,
                    icon: const Icon(LucideIcons.arrowUpToLine),
                  ),
                ),
              ],
            ),
            if (packageVersionsToChangeCount > 0)
              Row(
                children: [
                  FilledButton(
                    onPressed: onApplyChanges,
                    child: const Text('Apply changes'),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'You have changed $packageVersionsToChangeCount package(s)',
                  ),
                  // button to clear all changes
                  Tooltip(
                    message: 'Clear all changes',
                    child: IconButton(
                      onPressed: onClearChanges,
                      icon: const Icon(LucideIcons.xCircle),
                    ),
                  ),
                ],
              ),
            const Spacer(),
            if (isLoading) //
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
                onPressed: onReload,
                icon: const Icon(LucideIcons.rotateCw),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String errorMessage;
  final void Function() onClose;

  const _ErrorView({
    required this.errorMessage,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                errorMessage,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -10),
              child: IconButton(
                onPressed: onClose,
                icon: const Icon(LucideIcons.x),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PackagesView extends StatelessWidget {
  final List<ProjectPackage> dependencies;
  final List<ProjectPackage> devDependencies;
  final void Function(String, String) onSelectPackageVersion;
  final void Function(String) onOpenPackageUrl;
  final void Function(String) onOpenPackageChangelogUrl;

  const _PackagesView({
    required this.dependencies,
    required this.devDependencies,
    required this.onSelectPackageVersion,
    required this.onOpenPackageUrl,
    required this.onOpenPackageChangelogUrl,
  });

  @override
  Widget build(BuildContext context) {
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
              itemCount: dependencies.length,
              itemBuilder: (context, index) {
                final dependency = dependencies[index];
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
                      onSelectPackageVersion(
                        dependency.name,
                        version,
                      );
                    },
                    onLatestVersionSelected: () {
                      onSelectPackageVersion(
                        dependency.name,
                        dependency.latestVersion,
                      );
                    },
                    onClearSelectedVersion: () {
                      onSelectPackageVersion(
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
              itemCount: devDependencies.length,
              itemBuilder: (context, index) {
                final dependency = devDependencies[index];
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
                      onSelectPackageVersion(
                        dependency.name,
                        version,
                      );
                    },
                    onLatestVersionSelected: () {
                      onSelectPackageVersion(
                        dependency.name,
                        dependency.latestVersion,
                      );
                    },
                    onClearSelectedVersion: () {
                      onSelectPackageVersion(
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
  }
}

class _HoverableListItemView extends StatefulWidget {
  final Widget child;

  const _HoverableListItemView({
    required this.child,
  });

  @override
  State<_HoverableListItemView> createState() => _HoverableListItemViewState();
}

class _HoverableListItemViewState extends State<_HoverableListItemView> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: Material(
        color: isHovering
            ? Theme.of(context).colorScheme.surfaceVariant
            : Colors.transparent,
        child: SizedBox(
          height: 48,
          child: widget.child,
        ),
      ),
    );
  }
}

class _PackageListItemView extends StatelessWidget {
  final ProjectPackage dependency;
  final void Function() onOpenPackageUrl;
  final void Function() onOpenPackageChangelogUrl;
  final void Function(String) onVersionSelected;
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
  final void Function(String) onSelected;

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
