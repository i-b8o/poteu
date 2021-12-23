import 'package:flutter/material.dart';
import 'package:poteu/helper/data/data.dart';
import 'package:poteu/helper/data/paragraph/paragraph.dart';
import 'package:poteu/views/filter_all_paragraphs_page/filter_all_paragraphs_page.dart';
import 'package:poteu/views/main_page/main_page.dart';

class ParagraphEdit extends StatelessWidget {
  ParagraphEdit(
      {Key? key,
      required this.text,
      required this.chapterNum,
      required this.paragraph})
      : super(key: key);
  final String text, chapterNum;
  final Paragraph paragraph;
  TextEditingController _controller = new TextEditingController();
  String _newText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
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
      body: ListView(
        children: <Widget>[
          TextFormField(
              maxLines: null,
              initialValue: text,
              onChanged: (value) => _newText = value),
          new RaisedButton(
            onPressed: () {
              editParagraph(chapterNum, paragraph, text, _newText);
              Navigator.pop(context);
            },
            child: new Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
