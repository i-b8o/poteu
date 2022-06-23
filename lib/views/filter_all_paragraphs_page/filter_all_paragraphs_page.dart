import 'package:flutter/material.dart';

import 'package:poteu/helper/data/data.dart';
import 'package:poteu/helper/data/paragraph/paragraph.dart';
import 'package:poteu/views/chapter_page/chapter_page.dart';

import 'package:poteu/widget/search_widget.dart';

import '../filters_page_card_widget/filters_page_card_widget.dart';

class FilterAllParagraphsPage extends StatefulWidget {
  const FilterAllParagraphsPage({Key? key}) : super(key: key);

  @override
  FilterAllParagraphsPageState createState() => FilterAllParagraphsPageState();
}

class FilterAllParagraphsPageState extends State<FilterAllParagraphsPage> {
  late List<Paragraph> paragraphs;
  String query = '';

  @override
  void initState() {
    super.initState();

    paragraphs = allParagraphs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildSearch(),
        centerTitle: true,
      ),
      body: Stack(children: [
        Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: paragraphs.length,
                itemBuilder: (context, index) {
                  final paragraph = paragraphs[index];

                  return buildParagraph(paragraph);
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Поиск...',
        onChanged: searchParagraph,
      );

  Widget buildParagraph(Paragraph paragraph) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChapterPage(
                      chapter: allChapters[int.parse(paragraph.chapter)],
                    )),
          );
        },
        child: FiltersPageCardWidget(
          text: paragraph.text[0],
        ),
      );

  void searchParagraph(String query) {
    final paragraphs = allParagraphs.where((paragraph) {
      final nameLower = paragraph.text[0].toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.paragraphs = paragraphs;
    });
  }
}
