import 'package:flutter/material.dart';

class ParagraphEdit extends StatelessWidget {
  ParagraphEdit({Key? key, required this.text}) : super(key: key);
  final String text;
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          TextFormField(
              maxLines: null,
              initialValue: text,
              style: TextStyle(fontSize: 22),
              onChanged: (value) => print(value)),
          new RaisedButton(
            onPressed: () {
              // You can also use the controller to manipuate what is shown in the
              // text field. For example, the clear() method removes all the text
              // from the text field.
              _controller.clear();
            },
            child: new Text('CLEAR'),
          ),
        ],
      ),
    );
  }
}
