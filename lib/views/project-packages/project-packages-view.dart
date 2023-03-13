import 'package:dart_lens/functions/url.dart';
import 'package:dart_lens/views/project-packages/project-packages-view-bloc.dart';
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
        if (viewModel.packageVersionsToChange.isNotEmpty)
          Material(
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SeparatedRow(
                children: [
                  ElevatedButton(
                    onPressed: () {
/*
                              context
                                  .read<ProjectPackagesViewBloc>()
                                  .changePackageVersions();
*/
                    },
                    child: const Text('Apply changes'),
                  ),
                  Text(
                    'You have changed ${viewModel.packageVersionsToChange.length} package(s)',
                  ),
                ],
                separatorBuilder: () => const SizedBox(width: 8),
              ),
            ),
          ),
        if (viewModel.packageVersionsToChange.isNotEmpty) //
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

    final isLatestVersionNotInstalled =
        dependency.isLatestVersionInstalled != null &&
            !dependency.isLatestVersionInstalled!;

    return SeparatedRow(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: selectVersionBackgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: PopupMenuButton<String>(
              tooltip: 'Select version',
              initialValue: dependency.installedVersion,
              onSelected: (version) {
                context
                    .read<ProjectPackagesViewBloc>()
                    .selectPackageVersion(dependency.name, version);
              },
              itemBuilder: (itemBuilderContext) {
                return dependency.availableVersions?.map((version) {
                      return PopupMenuItem<String>(
                        value: version.version,
                        enabled: version.isInstallable,
                        child: _VersionMenuItemView(version: version),
                      );
                    }).toList() ??
                    [];
              },
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
        if (isLatestVersionNotInstalled)
          Tooltip(
            message: 'New version: ${dependency.installableVersion}',
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: newVersionBackgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SeparatedRow(
                  children: [
                    Icon(
                      CupertinoIcons.up_arrow,
                      color: newVersionTextColor,
                      size: 12,
                    ),
                    Text(
                      dependency.installableVersion ?? '',
                      style: textStyle?.copyWith(
                        color: newVersionTextColor,
                      ),
                    ),
                  ],
                  separatorBuilder: () => const SizedBox(width: 2),
                ),
              ),
            ),
          ),
        if (dependency.changeToVersion != null)
          Tooltip(
            message: 'Change to version: ${dependency.changeToVersion}',
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: changeToVersionBackgroundColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SeparatedRow(
                  children: [
                    Icon(
                      CupertinoIcons.arrow_2_squarepath,
                      color: changeToVersionTextColor,
                      size: 12,
                    ),
                    Text(
                      dependency.changeToVersion ?? '',
                      style: textStyle?.copyWith(
                        color: changeToVersionTextColor,
                      ),
                    ),
                  ],
                  separatorBuilder: () => const SizedBox(width: 2),
                ),
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
        if (version.isInstalled)
          const Icon(
            CupertinoIcons.checkmark,
            size: 12,
          ),
        Text(version.version),
      ],
      separatorBuilder: () => const SizedBox(width: 2),
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
