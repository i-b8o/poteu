import 'package:flutter/material.dart';
import 'package:poteu/views/filter_all_paragraphs_page/filter_all_paragraphs_page.dart';
import 'package:poteu/views/main_page/main_page.dart';

class ParagraphEdit extends StatelessWidget {
  ParagraphEdit({Key? key, required this.text}) : super(key: key);
  final String text;
  TextEditingController _controller = new TextEditingController();
  // void _change()
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
              onChanged: (value) => print(value)),
          new RaisedButton(
            onPressed: () {},
            child: new Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}