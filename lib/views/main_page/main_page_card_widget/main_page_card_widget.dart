import 'package:flutter/material.dart';
import 'package:poteu/helper/data/chapter/chapter.dart';

class MainPageCardWidget extends StatelessWidget {
  const MainPageCardWidget({Key? key, required this.chapter}) : super(key: key);

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const Border(
        bottom: BorderSide(width: 1.0, color: Color.fromRGBO(230, 230, 230, 1)),
      ),
      child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: Text(
            chapter.name,
            style: const TextStyle(
                color: Colors.black54, fontWeight: FontWeight.bold),
          )),
    );
  }
}
