import 'package:flutter/material.dart';

import 'package:poteu/presentation/screens/chapter/model/chapter_arguments.dart';

class ChapterCard extends StatelessWidget {
  const ChapterCard(
      {Key? key,
      required this.name,
      required this.num,
      required this.chapterOrderNum,
      required this.totalChapters,
      required this.chapterID})
      : super(key: key);
  final String name, num;
  final int chapterID, chapterOrderNum, totalChapters;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/chapter',
            arguments: ChapterArguments(
                chapterOrderNum: chapterOrderNum,
                totalChapters: totalChapters,
                scrollTo: 0));
      },
      child: Card(
        margin: EdgeInsets.zero,
        shape: Border(
          bottom: BorderSide(width: 1.0, color: Theme.of(context).shadowColor),
        ),
        child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            alignment: Alignment.centerLeft,
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Column(
              children: [
                Text.rich(
                  TextSpan(
                      text: num.isEmpty ? '' : '$num. ',
                      style: Theme.of(context).textTheme.bodyText1,
                      children: [
                        TextSpan(
                          text: name,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ]),
                ),
              ],
            )),
      ),
    );
  }
}
