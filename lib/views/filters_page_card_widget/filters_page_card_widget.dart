import 'package:flutter/material.dart';

class FiltersPageCardWidget extends StatelessWidget {
  const FiltersPageCardWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const Border(
        bottom: BorderSide(width: 1.0, color: Color.fromRGBO(230, 230, 230, 1)),
      ),
      child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8.0),
          height: MediaQuery.of(context).size.height / 8,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black54, fontWeight: FontWeight.bold),
          )),
    );
  }
}
