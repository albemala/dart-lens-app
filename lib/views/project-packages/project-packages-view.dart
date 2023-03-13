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
    return SingleChildScrollView(
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
      child: ColoredBox(
        color: isHovering.value
            ? Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.3)
            : Colors.transparent,
        child: SizedBox(
          height: 48,
          child: SeparatedRow(
            children: [
              _PackageNameView(dependency: dependency),
              if (!isHovering.value && dependency.installedVersion != null)
                _PackageVersionView(dependency: dependency),
              if (isHovering.value && dependency.availableVersions != null)
                _PackageVersionsDropdownView(dependency: dependency),
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

class _PackageVersionView extends StatelessWidget {
  final PackageViewModel dependency;

  const _PackageVersionView({
    required this.dependency,
  });

  @override
  Widget build(BuildContext context) {
    final isLatestVersionNotInstalled =
        dependency.isLatestVersionInstalled != null &&
            !dependency.isLatestVersionInstalled!;
    return SeparatedRow(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .tertiaryContainer
                .withOpacity(0.6),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              dependency.installedVersion ?? '',
            ),
          ),
        ),
        if (isLatestVersionNotInstalled)
          Tooltip(
            message: 'New version: ${dependency.installableVersion}',
            child: Icon(
              CupertinoIcons.arrow_up_circle_fill,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
      ],
      separatorBuilder: () => const SizedBox(width: 2),
    );
  }
}

class _PackageVersionsDropdownView extends StatelessWidget {
  final PackageViewModel dependency;

  const _PackageVersionsDropdownView({
    required this.dependency,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: PopupMenuButton(
          tooltip: 'Select version',
          child: SeparatedRow(
            children: [
              Text(
                dependency.installedVersion ?? '',
              ),
              const Icon(
                CupertinoIcons.chevron_down,
                size: 12,
              ),
            ],
            separatorBuilder: () => const SizedBox(width: 2),
          ),
          itemBuilder: (context) {
            return dependency.availableVersions
                    ?.map(
                      (version) => PopupMenuItem(
                        value: version,
                        enabled: version.isInstallable,
                        child: _VersionMenuItemView(version: version),
                      ),
                    )
                    .toList() ??
                [];
          },
        ),
      ),
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
