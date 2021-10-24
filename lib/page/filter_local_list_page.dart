import 'package:flutter/material.dart';
import 'package:poteu/helper/data/data.dart';
import 'package:poteu/helper/data/paragraph/paragraph.dart';
import 'package:poteu/widget/search_widget.dart';

class FilterLocalListPage extends StatefulWidget {
  @override
  FilterLocalListPageState createState() => FilterLocalListPageState();
}

class FilterLocalListPageState extends State<FilterLocalListPage> {
  late List<Paragraph> paragraphs;
  String query = '';

  @override
  void initState() {
    super.initState();

    paragraphs = allParagraphs;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // title: Text(MyApp.title),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            buildSearch(),
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
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Hint text',
        onChanged: searchBook,
      );

  Widget buildParagraph(Paragraph paragraph) => ListTile(
        title: Text(paragraph.text[0]),
      );

  void searchBook(String query) {
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
