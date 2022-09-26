import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:regulation_api/regulation_api.dart';

import 'package:poteu/presentation/screens/chapter/bloc/links/links_bloc.dart';
import 'package:poteu/presentation/screens/chapter/bloc/page_view/bloc.dart';
import 'package:poteu/presentation/screens/chapter/bloc/paragraph_card/paragraph_card_cubit.dart';
import 'package:poteu/presentation/screens/chapter/bloc/paragraph_table/paragraph_table_cubit.dart';
import 'package:poteu/presentation/screens/chapter/model/chapter_arguments.dart';

class ParagraphTable extends StatelessWidget {
  final String content;
  final List<int> ids;

  Future<void> goTo(BuildContext context, String href) async {
    int? chapterID;
    int? paragraphID;

    if (href.contains("#")) {
      // href contains a chapter id and a paragraph id
      List<String> chapterParagraphIDs = href.split("#");
      String chapterIDStr = chapterParagraphIDs[0];
      String paragraphIDStr = chapterParagraphIDs[1];

      paragraphID = int.tryParse(paragraphIDStr) ?? 0;
      chapterID = int.tryParse(chapterIDStr) ?? 0;
      // Current page link
      int index = ids.indexOf(paragraphID);
      if (index > 0) {
        context.read<LinksBloc>().add(EventLinkPressed(index + 1));
        return;
      }
    } else {
      chapterID = int.tryParse(href);
    }

    // Another page
    int totalChapters = context.read<PageViewBloc>().totalChapters;
    GoTo? _goTo =
        context.read<ParagraphCardCubit>().goTo(chapterID, paragraphID);
    if (_goTo == null) {
      return;
    }

    Navigator.pushNamed(context, '/chapter',
        arguments: ChapterArguments(
            chapterOrderNum: _goTo.chapterOrderNum,
            totalChapters: totalChapters,
            scrollTo: _goTo.paragraphOrderNum));
  }

  const ParagraphTable({Key? key, required this.content, required this.ids})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => ParagraphTableCubit(),
      child: BlocBuilder<ParagraphTableCubit, bool>(
          builder: (context, state) => state
              ? GestureDetector(
                  onTap: () {
                    context.read<ParagraphTableCubit>().collapse();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.zoom_out_map_rounded,
                        size: size.width < size.height
                            ? size.width * 0.05
                            : size.height * 0.05,
                      ),
                      SizedBox(
                        width: size.width * 0.01,
                      ),
                      Center(
                          child: Text(
                        "Развернуть",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      )),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () {
                              context.read<ParagraphTableCubit>().expand();
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 2.0),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                                Text("Свернуть",
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).iconTheme.color,
                                        fontWeight: FontWeight.w400))
                              ],
                            )),
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        color: Theme.of(context)
                            .textTheme
                            .headline2!
                            .backgroundColor,
                        child: HtmlWidget(
                          content,
                          textStyle: Theme.of(context).textTheme.headline2,
                          customStylesBuilder: (element) {
                            switch (element.localName) {
                              case 'table':
                                return {
                                  'border': '1px solid',
                                  'border-collapse': 'collapse',
                                  'font-size': '16px',
                                  'line-height': '18px',
                                  'letter-spacing': '0',
                                  'font-weight': '400',
                                  'font-family': 'Times New Roman',
                                };
                              case 'td':
                                return {
                                  'border': '1px solid',
                                  'vertical-align': 'top'
                                };
                            }
                            if (element.className.contains('align_center')) {
                              return {'text-align': 'center', 'width': '100%'};
                            }

                            return null;
                          },
                          onTapUrl: (href) async {
                            goTo(context, href);
                            return false;
                          },
                        ),
                      ),
                    ),
                  ],
                )),
    );
  }
}
