import 'package:flutter/material.dart';
import 'package:poteu/helper/data/chapter/chapter.dart';
import 'package:poteu/helper/data/data.dart';
import 'package:poteu/views/chapter_page/chapter_page.dart';
import 'package:poteu/views/filter_all_paragraphs_page/filter_all_paragraphs_page.dart';
import 'main_page_card_widget/main_page_card_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget buildChapter(Chapter chapter) => GestureDetector(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ПОТЭУ-903н-2020"),
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: allChapters.length,
              itemBuilder: (context, index) {
                final chapter = allChapters[index];

                return buildChapter(chapter);
              },
            ),
          ),
        ],
      ),
    );
  }
}
