import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poteu/presentation/widgets/regulation_app_bar.dart';

import 'package:poteu/presentation/screens/navigation_drawer/navigation_drawer.dart'
    as nav;
import 'package:poteu/presentation/screens/table_of_contents/bloc/table_of_contents/table_of_contents_bloc.dart';
import 'package:poteu/presentation/screens/table_of_contents/view/local_widgets/app_bar/app_bar.dart';
import 'package:poteu/presentation/screens/table_of_contents/view/local_widgets/body/chapter_card.dart';

class TableOfContentsPage extends StatelessWidget {
  const TableOfContentsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(Theme.of(context).appBarTheme.elevation!),
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: RegulationAppBar(child: TableOfContentsAppBar()),
          )),
      drawer: nav.NavigationDrawer(),
      body: ListView(
          children: context.select(
        (TableOfContentsBloc bloc) => bloc.chapters
            .map((e) => ChapterCard(
                  name: e.name,
                  num: e.num,
                  chapterID: e.id,
                  chapterOrderNum: e.orderNum,
                  totalChapters: bloc.chapters.length,
                ))
            .toList(),
      )),
    );
  }
}
