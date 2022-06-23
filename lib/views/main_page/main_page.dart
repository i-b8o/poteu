import 'package:flutter/material.dart';
import 'package:poteu/bloc/bloc.dart';
import 'package:poteu/constants.dart';
import 'package:poteu/helper/data/chapter/chapter.dart';
import 'package:poteu/helper/data/data.dart';
import 'package:poteu/views/chapter_page/chapter_page.dart';
import 'package:poteu/views/filter_all_paragraphs_page/filter_all_paragraphs_page.dart';
import 'package:provider/provider.dart';

import 'main_page_card_widget/main_page_card_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Constants.title),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FilterAllParagraphsPage()),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
          centerTitle: true,
        ),
        body: Consumer<Bloc>(builder: (context, _bloc, child) {
          return Stack(children: [
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: allChapters.length,
                    itemBuilder: (context, index) {
                      final chapter = allChapters[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChapterPage(
                                      chapter: chapter,
                                    )),
                          );
                        },
                        child: MainPageCardWidget(chapter: chapter),
                      );
                    },
                  ),
                ),
              ],
            ),
          ]);
        }));
  }
}
