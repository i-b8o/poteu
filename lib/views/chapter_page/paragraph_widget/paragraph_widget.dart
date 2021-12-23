import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:poteu/helper/data/table/table.dart';
import 'package:poteu/views/chapter_page/paragraph_edit/paragraph_edit.dart';

class ParagraphWidget extends StatefulWidget {
  ParagraphWidget({Key? key, required this.text, required this.tables})
      : super(key: key);
  final List<String> text;
  final List<ParagraphTable> tables;

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
      var result = await flutterTts.speak(this.widget.text.toString());
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
                        builder: (context) =>
                            ParagraphEdit(text: _pressedText)),
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

    Container img = widget.tables.isNotEmpty
        ? Container(
            child: Column(
            children: [
              Text(
                  "${widget.tables[0].num.isNotEmpty ? "Таблица" + widget.tables[0].num : ""}"),
              Image.asset("assets/images/${widget.tables[0].img}.png"),
            ],
          ))
        : Container();
    return Column(
      children: [
        for (var t in widget.text)
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
