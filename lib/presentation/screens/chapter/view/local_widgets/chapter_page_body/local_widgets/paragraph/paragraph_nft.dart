import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ParagraphNFT extends StatelessWidget {
  final String content;

  const ParagraphNFT({key, required this.content});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        color: Theme.of(context).textTheme.headline2!.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: HtmlWidget(
            content,
            customStylesBuilder: (element) => {
              'font-family': 'Courier New,"Monospace"',
              'white-space': 'pre',
              'font-size': '17.5px',
              'letter-spacing': '0',
              'line-height': '5px',
              'font-weight': '500',
            },
          ),
        ),
      ),
    );
  }
}
