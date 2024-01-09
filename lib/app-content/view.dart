import 'package:dart_lens/app-content/app-bottom-view.dart';
import 'package:dart_lens/app-content/app-top-view.dart';
import 'package:dart_lens/project-packages/view.dart';
import 'package:dart_lens/project-structure/view.dart';
import 'package:dart_lens/string-literals/view.dart';
import 'package:flutter/material.dart';

class AppContentView extends StatelessWidget {
  const AppContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTopViewBuilder(),
            Divider(),
            TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Packages'),
                Tab(text: 'Project structure'),
                Tab(text: 'String literals'),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ProjectPackagesViewBuilder(),
                  ProjectStructureViewBuilder(),
                  StringLiteralsViewBuilder(),
                ],
              ),
            ),
            Divider(),
            AppBottomViewBuilder(),
          ],
        ),
      ),
    );
  }
}
