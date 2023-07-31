import 'package:dart_lens/views/project-structure/project-structure-view-conductor.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProjectStructureView extends StatelessWidget {
  const ProjectStructureView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProjectStructureViewConductor>(
      create: ProjectStructureViewConductor.fromContext,
      child: Column(
        children: [
          const Divider(),
          const _ActionBarView(),
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
                  child: const _ProjectStructureView(),
                );
              },
            ),
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
    return Consumer<ProjectStructureViewConductor>(
      builder: (context, conductor, child) {
        return Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SeparatedRow(
              children: [
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
              separatorBuilder: () => const SizedBox(width: 8),
            ),
          ),
        );
      },
    );
  }
}

class _ProjectStructureView extends StatelessWidget {
  const _ProjectStructureView();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectStructureViewConductor>(
      builder: (context, conductor, child) {
        return PrimaryElementWidget(
          color: Colors.grey,
          child: SeparatedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElementPathWidget(path: conductor.projectPath),
              ...conductor.directories.map((projectDirectory) {
                return DirectoryElementView(projectDirectory: projectDirectory);
              }),
            ],
            separatorBuilder: () => const SizedBox(height: 12),
          ),
        );
      },
    );
  }
}

class DirectoryElementView extends StatelessWidget {
  final ProjectDirectory projectDirectory;

  const DirectoryElementView({
    super.key,
    required this.projectDirectory,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryElementWidget(
      color: Colors.teal,
      child: SeparatedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElementPathWidget(path: projectDirectory.path),
          SeparatedRow(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: projectDirectory.files.map((projectFile) {
              return FileElementView(projectFile: projectFile);
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
  final ProjectFile projectFile;

  const FileElementView({
    super.key,
    required this.projectFile,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryElementWidget(
      color: Colors.green,
      child: SeparatedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElementPathWidget(path: projectFile.name),
          ...projectFile.entities.map(buildEntityView),
        ],
        separatorBuilder: () => const SizedBox(height: 12),
      ),
    );
  }
}

Widget buildEntityView(EntityDefinition entity) {
  switch (entity.type) {
    case EntityDefinitionType.class_:
      final classDefinition = entity as ClassDefinition;
      return ClassElementView(classDefinition: classDefinition);
    case EntityDefinitionType.function_:
      final functionDefinition = entity as FunctionDefinition;
      return FunctionElementView(functionDefinition: functionDefinition);
    case EntityDefinitionType.enum_:
      final enumDefinition = entity as EnumDefinition;
      return EnumElementView(enumDefinition: enumDefinition);
    case EntityDefinitionType.extension_:
    case EntityDefinitionType.mixin_:
    case EntityDefinitionType.typedef_:
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
  final ClassDefinition classDefinition;

  const ClassElementView({
    super.key,
    required this.classDefinition,
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
              ElementNameWidget(name: classDefinition.name),
            ],
          ),
          ...classDefinition.properties.map(
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
          ...classDefinition.constructors.map(
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
          ...classDefinition.methods.map(
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
  final FunctionDefinition functionDefinition;

  const FunctionElementView({
    super.key,
    required this.functionDefinition,
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
              ElementTypeWidget(type: functionDefinition.returnType),
              ElementNameWidget(name: functionDefinition.name),
            ],
            separatorBuilder: () => const SizedBox(width: 8),
          ),
          ...functionDefinition.parameters.map(
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
  final EnumDefinition enumDefinition;

  const EnumElementView({
    super.key,
    required this.enumDefinition,
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
              ElementNameWidget(name: enumDefinition.name),
            ],
          ),
          ...enumDefinition.values.map(
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
