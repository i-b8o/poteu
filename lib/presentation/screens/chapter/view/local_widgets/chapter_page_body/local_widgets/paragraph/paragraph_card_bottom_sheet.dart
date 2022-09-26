import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poteu/bloc/speak/speak_cubit.dart';

class ParagraphCardBottomSheet extends StatelessWidget {
  const ParagraphCardBottomSheet({
    Key? key,
    required this.content,
    required this.paragraphs,
  }) : super(key: key);

  final List<String> content;
  final List<String> paragraphs;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeakCubit, bool>(
      builder: (context, state) {
        return Wrap(alignment: WrapAlignment.center, children: [
          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              await context.read<SpeakCubit>().speak(content);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              height: 70,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Row(children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Icon(
                  Icons.code_outlined,
                  color: Theme.of(context).appBarTheme.toolbarTextStyle!.color,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Text(
                  'Абзац',
                ),
              ]),
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width * 0.95,
            color: Theme.of(context).bottomAppBarColor,
          ),
          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              await context.read<SpeakCubit>().speak(paragraphs);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              height: 70,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Row(children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Icon(Icons.feed_outlined,
                    color:
                        Theme.of(context).appBarTheme.toolbarTextStyle!.color),
                SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                Text('Главу'),
              ]),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.only(bottom: 40),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              height: 70,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Center(child: Text("Отменить")),
            ),
          ),
        ]);
      },
    );
  }
}
