import 'package:flutter/material.dart';

import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:poteu/bloc/bloc.dart';
import 'package:poteu/helper/data/paragraph/paragraph.dart';
import 'package:poteu/views/chapter_page/paragraph_edit/paragraph_edit.dart';
import 'package:poteu/widget/pitch_widget.dart';
import 'package:poteu/widget/rate_widget.dart';
import 'package:provider/provider.dart';

class ParagraphWidget extends StatefulWidget {
  ParagraphWidget({Key? key, required this.chapterNum, required this.paragraph})
      : super(key: key);
  final Paragraph paragraph;
  final String chapterNum;
  @override
  State<ParagraphWidget> createState() => _ParagraphWidgetState();
}

class _ParagraphWidgetState extends State<ParagraphWidget> {
  String _pressedText = "";
  @override
  Widget build(BuildContext context) {
    List<FocusedMenuItem> _menuItems(MyBloc _bloc, bool _playing) {
      return !_playing
          ? <FocusedMenuItem>[
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
              FocusedMenuItem(
                  trailingIcon: Icon(MdiIcons.volumeHigh),
                  title: Text("Прослушать параграф"),
                  onPressed: () {
                    _bloc.speak(this.widget.paragraph.text.toString());
                  }),
              FocusedMenuItem(
                  trailingIcon: Icon(Icons.settings),
                  title: Text("Настройка"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Text("Воспроизведение"),
                              actions: [
                                Column(
                                  children: [
                                    RateWidget(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    PitchWidget(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.teal)),
                                  child: TextButton(
                                      onPressed: () {
                                        _bloc.stop();
                                        Navigator.pop(context);
                                      },
                                      child: Text('Ok')),
                                )
                              ],
                            );
                          },
                        );
                      },
                    );
                  }),
            ]
          : <FocusedMenuItem>[
              FocusedMenuItem(
                  trailingIcon: Icon(MdiIcons.stopCircle),
                  title: Text("Остановить"),
                  onPressed: () {
                    _bloc.stop();
                  }),
            ];
    }

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
    return Consumer<MyBloc>(builder: (context, _bloc, _) {
      return Column(
        children: [
          for (var t in widget.paragraph.text)
            StreamBuilder(
                stream: _bloc.playingStateController,
                builder: (context, snapshot) {
                  bool _playing = false;
                  if (snapshot.hasData) {
                    _playing = snapshot.data as bool;
                  }
                  return FocusedMenuHolder(
                    animateMenuItems: true,
                    openWithTap: true,
                    onPressed: () {
                      _pressedText = t;
                    },
                    menuItems: _menuItems(_bloc, _playing),
                    child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Text(
                          t,
                          style: const TextStyle(fontSize: 17.0),
                        )),
                  );
                }),
          img,
        ],
      );
    });
  }
}
