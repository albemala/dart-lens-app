import 'package:dart_lens/views/project-structure/project-structure-view-bloc.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectStructureView extends StatelessWidget {
  const ProjectStructureView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ProjectStructureViewBloc.fromContext,
      child: BlocBuilder<ProjectStructureViewBloc, ProjectStructureViewModel>(
        builder: _buildView,
      ),
    );
  }

  Widget _buildView(BuildContext context, ProjectStructureViewModel viewModel) {
    return Column(
      children: [
        const Divider(),
        Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SeparatedRow(
              children: [
                const Spacer(),
                if (viewModel.isLoading) //
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
                      context //
                          .read<ProjectStructureViewBloc>()
                          .reload();
                    },
                    icon: const Icon(CupertinoIcons.arrow_clockwise),
                  ),
                ),
              ],
              separatorBuilder: () => const SizedBox(width: 8),
            ),
          ),
        ),
        const Divider(),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return InteractiveViewer(
                constrained: false,
                minScale: 0.1,
                boundaryMargin: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth,
                  vertical: constraints.maxHeight,
                ),
                child: ProjectStructureElementView(viewModel: viewModel),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProjectStructureElementView extends StatelessWidget {
  final ProjectStructureViewModel viewModel;

  const ProjectStructureElementView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryElementWidget(
      color: Colors.grey,
      child: SeparatedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElementPathWidget(path: viewModel.projectPath),
          ...viewModel.directories.map((directoryViewModel) {
            return DirectoryElementView(viewModel: directoryViewModel);
          }),
        ],
        separatorBuilder: () => const SizedBox(height: 12),
      ),
    );
  }
}

class DirectoryElementView extends StatelessWidget {
  final DirectoryViewModel viewModel;

  const DirectoryElementView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryElementWidget(
      color: Colors.teal,
      child: SeparatedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElementPathWidget(path: viewModel.path),
          SeparatedRow(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: viewModel.files.map((fileViewModel) {
              return FileElementView(viewModel: fileViewModel);
            }).toList(),
            separatorBuilder: () => const SizedBox(width: 12),
          ),
        ],
        separatorBuilder: () => const SizedBox(height: 12),
      ),
    );
  }
}

class FileElementView extends StatelessWidget {
  final FileViewModel viewModel;

  const FileElementView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryElementWidget(
      color: Colors.green,
      child: SeparatedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElementPathWidget(path: viewModel.name),
          ...viewModel.entities.map(buildEntityView),
        ],
        separatorBuilder: () => const SizedBox(height: 12),
      ),
    );
  }
}

Widget buildEntityView(EntityViewModel entity) {
  switch (entity.type) {
    case EntityViewModelType.class_:
      final classViewModel = entity as ClassViewModel;
      return ClassElementView(viewModel: classViewModel);
    case EntityViewModelType.function_:
      final functionViewModel = entity as FunctionViewModel;
      return FunctionElementView(viewModel: functionViewModel);
    case EntityViewModelType.enum_:
      final enumViewModel = entity as EnumViewModel;
      return EnumElementView(viewModel: enumViewModel);
    case EntityViewModelType.extension_:
    case EntityViewModelType.mixin_:
    case EntityViewModelType.typedef_:
      return PrimaryElementWidget(
        color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entity.type.name),
          ],
        ),
      );
  }
}

class ClassElementView extends StatelessWidget {
  final ClassViewModel viewModel;

  const ClassElementView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryElementWidget(
      color: Colors.yellow,
      child: SeparatedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ElementTagWidget(tag: 'Class'),
              const SizedBox(width: 8),
              ElementNameWidget(name: viewModel.name),
            ],
          ),
          ...viewModel.properties.map(
            (property) {
              return SecondaryElementWidget(
                color: Colors.pink,
                child: SeparatedRow(
                  children: [
                    const ElementTagWidget(tag: 'Property'),
                    ElementTypeWidget(type: property.type),
                    ElementNameWidget(name: property.name),
                  ],
                  separatorBuilder: () => const SizedBox(width: 8),
                ),
              );
            },
          ),
          ...viewModel.constructors.map(
            (constructor) => SecondaryElementWidget(
              color: Colors.indigo,
              child: SeparatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeparatedRow(
                    children: [
                      const ElementTagWidget(tag: 'Constructor'),
                      ElementNameWidget(name: constructor.name),
                    ],
                    separatorBuilder: () => const SizedBox(width: 8),
                  ),
                  ...constructor.parameters.map(
                    (parameter) => SeparatedRow(
                      children: [
                        const SizedBox(width: 8),
                        const ElementTagWidget(tag: 'Parameter'),
                        ElementTypeWidget(type: parameter.type),
                        ElementNameWidget(name: parameter.name),
                      ],
                      separatorBuilder: () => const SizedBox(width: 8),
                    ),
                  ),
                ],
                separatorBuilder: () => const SizedBox(height: 8),
              ),
            ),
          ),
          ...viewModel.methods.map(
            (method) => SecondaryElementWidget(
              color: Colors.cyan,
              child: SeparatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SeparatedRow(
                    children: [
                      const ElementTagWidget(tag: 'Method'),
                      ElementTypeWidget(type: method.returnType),
                      ElementNameWidget(name: method.name),
                    ],
                    separatorBuilder: () => const SizedBox(width: 8),
                  ),
                  ...method.parameters.map(
                    (parameter) => SeparatedRow(
                      children: [
                        const SizedBox(width: 8),
                        const ElementTagWidget(tag: 'Parameter'),
                        ElementTypeWidget(type: parameter.type),
                        ElementNameWidget(name: parameter.name),
                      ],
                      separatorBuilder: () => const SizedBox(width: 8),
                    ),
                  ),
                ],
                separatorBuilder: () => const SizedBox(height: 8),
              ),
            ),
          ),
        ],
        separatorBuilder: () => const SizedBox(height: 8),
      ),
    );
  }
}

class FunctionElementView extends StatelessWidget {
  final FunctionViewModel viewModel;

  const FunctionElementView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryElementWidget(
      color: Colors.blue,
      child: SeparatedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SeparatedRow(
            children: [
              const ElementTagWidget(tag: 'Function'),
              ElementTypeWidget(type: viewModel.returnType),
              ElementNameWidget(name: viewModel.name),
            ],
            separatorBuilder: () => const SizedBox(width: 8),
          ),
          ...viewModel.parameters.map(
            (parameter) => SeparatedRow(
              children: [
                const SizedBox(width: 8),
                const ElementTagWidget(tag: 'Parameter'),
                ElementTypeWidget(type: parameter.type),
                ElementNameWidget(name: parameter.name),
              ],
              separatorBuilder: () => const SizedBox(width: 8),
            ),
          ),
        ],
        separatorBuilder: () => const SizedBox(height: 8),
      ),
    );
  }
}

class EnumElementView extends StatelessWidget {
  final EnumViewModel viewModel;

  const EnumElementView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryElementWidget(
      color: Colors.purple,
      child: SeparatedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ElementTagWidget(tag: 'Enum'),
              const SizedBox(width: 8),
              ElementNameWidget(name: viewModel.name),
            ],
          ),
          ...viewModel.values.map(
            (value) => SecondaryElementWidget(
              color: Colors.purple,
              child: Row(
                children: [
                  const ElementTagWidget(tag: 'Value'),
                  const SizedBox(width: 8),
                  ElementNameWidget(name: value),
                ],
              ),
            ),
          ),
        ],
        separatorBuilder: () => const SizedBox(height: 8),
      ),
    );
  }
}

class ElementPathWidget extends StatelessWidget {
  final String path;

  const ElementPathWidget({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          path,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ),
    );
  }
}

class ElementTagWidget extends StatelessWidget {
  final String tag;

  const ElementTagWidget({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tag,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            tag.characters.first.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      ),
    );
  }
}

class ElementTypeWidget extends StatelessWidget {
  final String type;

  const ElementTypeWidget({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
          type,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: GoogleFonts.firaCode().fontFamily,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ),
    );
  }
}

class ElementNameWidget extends StatelessWidget {
  final String name;

  const ElementNameWidget({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontFamily: GoogleFonts.firaCode().fontFamily,
          ),
    );
  }
}

class PrimaryElementWidget extends StatelessWidget {
  final MaterialColor color;
  final Widget child;

  const PrimaryElementWidget({
    super.key,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ThemedWidget(
      color: color,
      child: Builder(
        builder: (context) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class SecondaryElementWidget extends StatelessWidget {
  final MaterialColor color;
  final Widget child;

  const SecondaryElementWidget({
    super.key,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ThemedWidget(
      color: color,
      child: Builder(
        builder: (context) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class ThemedWidget extends StatelessWidget {
  final MaterialColor color;
  final Widget child;

  const ThemedWidget({
    super.key,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = SeedColorScheme.fromSeeds(
      brightness: Theme.of(context).brightness,
      primaryKey: color,
      tones: FlexTones.vividSurfaces(Theme.of(context).brightness),
    );

    return Theme(
      data: ThemeData.from(
        colorScheme: colorScheme,
      ),
      child: child,
    );
  }
}
