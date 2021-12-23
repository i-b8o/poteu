import 'package:flutter/material.dart';
import 'package:poteu/bloc/bloc.dart';
import 'package:poteu/helper/data/chapter/chapter.dart';
import 'package:poteu/helper/data/data.dart';
import 'package:poteu/views/chapter_page/chapter_page.dart';
import 'package:poteu/views/filter_all_paragraphs_page/filter_all_paragraphs_page.dart';
import 'package:provider/provider.dart';
import 'package:unity_ads_plugin/unity_ads.dart';
import 'main_page_card_widget/main_page_card_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    UnityAds.init(gameId: "4512507", testMode: true);
  }

  Widget buildChapter(Chapter chapter) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChapterPage(
                      chapter: chapter,
                    )),
          );
        },
        child: MainPageCardWidget(chapter: chapter),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ПОТЭУ-903н-2020"),
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
          centerTitle: true,
        ),
        body: Consumer<Bloc>(builder: (context, _bloc, child) {
          return Stack(children: [
            Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: allChapters.length,
                    itemBuilder: (context, index) {
                      final chapter = allChapters[index];

                      return buildChapter(chapter);
                    },
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: 0.0,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    height: 50.0,
                    width: 320.0,
                    child: UnityBannerAd(
                      placementId: "Banner_Android",
                    ),
                  ),
                ))
          ]);
        }));
  }
}
