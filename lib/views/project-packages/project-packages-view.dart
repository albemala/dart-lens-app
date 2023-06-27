import 'package:dart_lens/functions/url.dart';
import 'package:dart_lens/views/project-packages/project-packages-view-bloc.dart';
import 'package:dart_lens/widgets/button.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProjectPackagesView extends StatelessWidget {
  const ProjectPackagesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ProjectPackagesViewBloc.new,
      child: BlocBuilder<ProjectPackagesViewBloc, ProjectPackagesViewModel>(
        builder: _buildView,
      ),
    );
  }

  Widget _buildView(BuildContext context, ProjectPackagesViewModel viewModel) {
    return Column(
      children: [
        const Divider(),
        Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SeparatedRow(
              children: [
                if (viewModel.dependencies.isNotEmpty &&
                    viewModel.devDependencies.isNotEmpty)
                  // dropdown to display all packages or only upgradable ones
                  DropdownButton<PackageFilter>(
                    isDense: true,
                    items: PackageFilter.values.map(
                      (filter) {
                        return DropdownMenuItem<PackageFilter>(
                          value: filter,
                          child: Text(filter.title),
                        );
                      },
                    ).toList(),
                    value: viewModel.packageFilter,
                    onChanged: (filter) {
                      if (filter == null) return;
                      context //
                          .read<ProjectPackagesViewBloc>()
                          .setPackageFilter(filter);
                    },
                  ),
                Tooltip(
                  message: 'Select to install all upgrades',
                  child: OutlinedButton(
                    onPressed: () {
                      context //
                          .read<ProjectPackagesViewBloc>()
                          .upgradeAllPackages();
                    },
                    child: const Text('Select all upgrades'),
                  ),
                ),
                if (viewModel.packageVersionsToChangeCount > 0)
                  SeparatedRow(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context //
                              .read<ProjectPackagesViewBloc>()
                              .applyChanges();
                        },
                        child: const Text('Apply changes'),
                      ),
                      Text(
                        'You have changed ${viewModel.packageVersionsToChangeCount} package(s)',
                      ),
                      // button to clear all changes
                      Tooltip(
                        message: 'Clear all changes',
                        child: IconButton(
                          onPressed: () {
                            context //
                                .read<ProjectPackagesViewBloc>()
                                .clearChanges();
                          },
                          icon: const Icon(CupertinoIcons.clear),
                        ),
                      ),
                    ],
                    separatorBuilder: () => const SizedBox(width: 8),
                  ),
                const Spacer(),
                if (viewModel.isLoading) //
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                // button to reload the project
                IconButton(
                  onPressed: () {
                    context //
                        .read<ProjectPackagesViewBloc>()
                        .reload();
                  },
                  icon: const Icon(CupertinoIcons.arrow_clockwise),
                ),
              ],
              separatorBuilder: () => const SizedBox(width: 16),
            ),
          ),
        ),
        const Divider(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (viewModel.dependencies.isNotEmpty)
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
                    itemCount: viewModel.dependencies.length,
                    itemBuilder: (context, index) {
                      final dependency = viewModel.dependencies[index];
                      return PackageView(dependency: dependency);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ),
                if (viewModel.devDependencies.isNotEmpty)
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
                    itemCount: viewModel.devDependencies.length,
                    itemBuilder: (context, index) {
                      final dependency = viewModel.devDependencies[index];
                      return PackageView(dependency: dependency);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PackageView extends HookWidget {
  final PackageViewModel dependency;

  const PackageView({
    super.key,
    required this.dependency,
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
          child: SeparatedRow(
            children: [
              _PackageNameView(dependency: dependency),
              if (dependency.installedVersion != null &&
                  dependency.availableVersions != null)
                _PackageVersionSelectorView(dependency: dependency),
              if (isHovering.value) //
                _PackageActionsView(dependency: dependency),
            ],
            separatorBuilder: () => const SizedBox(width: 8),
          ),
        ),
      ),
    );
  }
}

class _PackageNameView extends StatelessWidget {
  final PackageViewModel dependency;

  const _PackageNameView({
    required this.dependency,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: dependency.description ?? '',
      child: Text(
        dependency.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _PackageVersionSelectorView extends StatelessWidget {
  final PackageViewModel dependency;

  const _PackageVersionSelectorView({
    required this.dependency,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final selectVersionBackgroundColor =
        Theme.of(context).colorScheme.secondaryContainer;
    final selectVersionTextColor =
        Theme.of(context).colorScheme.onSecondaryContainer;
    final newVersionBackgroundColor =
        Theme.of(context).colorScheme.primaryContainer;
    final newVersionTextColor =
        Theme.of(context).colorScheme.onPrimaryContainer;
    final changeToVersionBackgroundColor =
        Theme.of(context).colorScheme.secondary;
    final changeToVersionTextColor = Theme.of(context).colorScheme.onSecondary;

    return SeparatedRow(
      children: [
        Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: selectVersionBackgroundColor,
          child: PopupMenuButton<String>(
            tooltip: 'Select version',
            initialValue: dependency.installedVersion,
            onSelected: (version) {
              context //
                  .read<ProjectPackagesViewBloc>()
                  .selectPackageVersion(
                    dependency.name,
                    version,
                  );
            },
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
                      color: selectVersionTextColor,
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_down,
                    color: selectVersionTextColor,
                    size: 12,
                  ),
                ],
                separatorBuilder: () => const SizedBox(width: 2),
              ),
            ),
          ),
        ),
        if (!dependency.isLatestVersionInstalled &&
            dependency.installableVersion != null)
          Tooltip(
            message:
                'Latest version: ${dependency.installableVersion}. Click to select.',
            child: SmallButtonWidget(
              backgroundColor: newVersionBackgroundColor,
              onPressed: () {
                context //
                    .read<ProjectPackagesViewBloc>()
                    .selectPackageVersion(
                      dependency.name,
                      dependency.installableVersion!,
                    );
              },
              child: SeparatedRow(
                children: [
                  Icon(
                    CupertinoIcons.up_arrow,
                    color: newVersionTextColor,
                    size: 12,
                  ),
                  Text(
                    dependency.installableVersion!,
                    style: textStyle?.copyWith(
                      color: newVersionTextColor,
                    ),
                  ),
                ],
                separatorBuilder: () => const SizedBox(width: 2),
              ),
            ),
          ),
        if (dependency.changeToVersion != null &&
            dependency.installedVersion != null)
          Tooltip(
            message:
                'Change to version: ${dependency.changeToVersion}. Click to reset.',
            child: SmallButtonWidget(
              backgroundColor: changeToVersionBackgroundColor,
              onPressed: () {
                context //
                    .read<ProjectPackagesViewBloc>()
                    .selectPackageVersion(
                      dependency.name,
                      dependency.installedVersion!,
                    );
              },
              child: SeparatedRow(
                children: [
                  Icon(
                    CupertinoIcons.arrow_2_squarepath,
                    color: changeToVersionTextColor,
                    size: 12,
                  ),
                  Text(
                    dependency.changeToVersion!,
                    style: textStyle?.copyWith(
                      color: changeToVersionTextColor,
                    ),
                  ),
                ],
                separatorBuilder: () => const SizedBox(width: 2),
              ),
            ),
          ),
      ],
      separatorBuilder: () => const SizedBox(width: 2),
    );
  }
}

class _VersionMenuItemView extends StatelessWidget {
  final PackageVersionViewModel version;

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

class _PackageActionsView extends StatelessWidget {
  final PackageViewModel dependency;

  const _PackageActionsView({
    required this.dependency,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // url icon button
        if (dependency.url != null)
          IconButton(
            tooltip: dependency.url,
            icon: const Icon(CupertinoIcons.link),
            onPressed: () => openUrl(dependency.url!),
          ),
        // changelog icon button
        if (dependency.changelogUrl != null)
          IconButton(
            tooltip: 'Changelog',
            icon: const Icon(CupertinoIcons.doc_text),
            onPressed: () => openUrl(dependency.changelogUrl!),
          ),
      ],
    );
  }
}
