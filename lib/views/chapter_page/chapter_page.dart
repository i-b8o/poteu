import 'package:flutter/material.dart';
import 'package:poteu/bloc/bloc.dart';
import 'package:poteu/helper/data/chapter/chapter.dart';
import 'package:poteu/helper/data/data.dart';
import 'package:poteu/helper/data/paragraph/paragraph.dart';
import 'package:poteu/views/filter_all_paragraphs_page/filter_all_paragraphs_page.dart';
import 'package:poteu/views/main_page/main_page.dart';
import 'package:provider/provider.dart';

import 'paragraph_widget/paragraph_widget.dart';

class ChapterPage extends StatefulWidget {
  const ChapterPage({
    Key? key,
    required this.chapter,
  }) : super(key: key);
  final Chapter chapter;

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  @override
  Widget build(BuildContext context) {
    List<Paragraph> paragraphs = widget.chapter.paragraphs;
    return Consumer<Bloc>(builder: (context, _bloc, _) {
      return WillPopScope(
        onWillPop: () async {
          _bloc.stop();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false,
          );
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                _bloc.stop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                  (route) => false,
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
          body: Stack(children: [
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.chapter.name,
                          style: const TextStyle(
                              fontSize: 21.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      for (var p in paragraphs)
                        ParagraphWidget(
                          paragraph: p,
                          chapterNum: widget.chapter.num,
                        ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 60.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                String n = prevNum(widget.chapter.num);
                                Chapter ch = getChapter(n);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChapterPage(
                                            chapter: ch,
                                          )),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.teal,
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                String n = nextNum(widget.chapter.num);
                                Chapter ch = getChapter(n);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChapterPage(
                                            chapter: ch,
                                          )),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.teal,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Positioned(
            //     bottom: 0.0,
            //     left: (_width - 320) / 2,
            //     child: Center(
            //       child: Container(
            //         height: 50.0,
            //         width: 320.0,
            //         child: UnityBannerAd(
            //           placementId: "chapter",
            //         ),
            //       ),
            //     )),
          ]),
        ),
      );
    });
  }
}
