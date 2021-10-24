import 'package:flutter/material.dart';
import 'package:poteu/helper/data/chapter/chapter.dart';
import 'package:poteu/helper/data/paragraph/paragraph.dart';
import 'package:poteu/views/filter_all_paragraphs_page/filter_all_paragraphs_page.dart';

class ChapterPage extends StatefulWidget {
  const ChapterPage({
    Key? key,
    required this.chapter,
  }) : super(key: key);
  final Chapter chapter;

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  @override
  Widget build(BuildContext context) {
    List<Paragraph> paragraphs = widget.chapter.paragraphs;

    return Scaffold(
      appBar: AppBar(
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
        title: const Text("ПОТЭУ-903н-2020"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.chapter.name,
                      style: const TextStyle(
                          fontSize: 21.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  for (var p in paragraphs)
                    ParagraphWidget(
                      text: p.text,
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParagraphWidget extends StatelessWidget {
  const ParagraphWidget({Key? key, required this.text}) : super(key: key);
  final List<String> text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var t in text)
          Container(
              margin: const EdgeInsets.all(8.0),
              child: Text(
                t,
                style: const TextStyle(fontSize: 17.0),
              ))
      ],
    );
  }
}
