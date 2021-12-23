import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:poteu/helper/data/paragraph/paragraph.dart';
import 'package:poteu/views/chapter_page/paragraph_edit/paragraph_edit.dart';

class ParagraphWidget extends StatefulWidget {
  ParagraphWidget({Key? key, required this.chapterNum, required this.paragraph})
      : super(key: key);
  final Paragraph paragraph;
  final String chapterNum;
  @override
  State<ParagraphWidget> createState() => _ParagraphWidgetState();
}

class _ParagraphWidgetState extends State<ParagraphWidget> {
  final FlutterTts flutterTts = FlutterTts();
  bool _playing = false;
  String _pressedText = "";
  @override
  Widget build(BuildContext context) {
    Future _speak() async {
      await flutterTts.setLanguage("ru-RU");
      var result =
          await flutterTts.speak(this.widget.paragraph.text.toString());
      if (result == 1) setState(() => _playing = true);
    }

    Future _stop() async {
      flutterTts.stop();

      setState(() => _playing = false);
    }

    List<FocusedMenuItem> _menuItems = !_playing
        ? <FocusedMenuItem>[
            FocusedMenuItem(
                trailingIcon: Icon(MdiIcons.volumeHigh),
                title: Text("Прослушать параграф"),
                onPressed: () {
                  _speak();
                }),
            FocusedMenuItem(
                trailingIcon: Icon(Icons.edit),
                title: Text("Редактировать параграф"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ParagraphEdit(
                              text: _pressedText,
                              chapterNum: this.widget.chapterNum,
                              paragraph: this.widget.paragraph,
                            )),
                  );
                }),
          ]
        : <FocusedMenuItem>[
            FocusedMenuItem(
                trailingIcon: Icon(MdiIcons.stopCircle),
                title: Text("Остановить"),
                onPressed: () {
                  _stop();
                }),
          ];

    Container img = widget.paragraph.tables.isNotEmpty
        ? Container(
            child: Column(
            children: [
              Text(
                  "${widget.paragraph.tables[0].num.isNotEmpty ? "Таблица" + widget.paragraph.tables[0].num : ""}"),
              Image.asset(
                  "assets/images/${widget.paragraph.tables[0].img}.png"),
            ],
          ))
        : Container();
    return Column(
      children: [
        for (var t in widget.paragraph.text)
          FocusedMenuHolder(
            animateMenuItems: true,
            openWithTap: true,
            onPressed: () {
              _pressedText = t;
            },
            menuItems: _menuItems,
            child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Text(
                  t,
                  style: const TextStyle(fontSize: 17.0),
                )),
          ),
        img,
      ],
    );
  }
}
