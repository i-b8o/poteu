import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:poteu/presentation/screens/chapter/view/local_widgets/chapter_page_body/local_widgets/paragraph/local_widgets/focused_menu_holder.dart';
import 'package:poteu/presentation/screens/chapter/view/local_widgets/chapter_page_body/local_widgets/paragraph/local_widgets/modals.dart';

import 'package:poteu/repository/regulation_repository.dart';
import 'package:poteu/utils/font.dart';
import 'package:poteu/utils/text.dart';

import 'package:poteu/presentation/screens/navigation_drawer/cubit/font/font_cubit.dart';
import 'package:poteu/presentation/screens/chapter/bloc/bottom_bar/bottom_bar_cubit.dart';
import 'package:poteu/presentation/screens/chapter/bloc/links/links_bloc.dart';
import 'package:poteu/presentation/screens/chapter/bloc/page_view/bloc.dart';
import 'package:poteu/presentation/screens/chapter/bloc/paragraph_card/paragraph_card_cubit.dart';
import 'package:poteu/presentation/screens/chapter/bloc/save_paragraph/save_paragraph_cubit.dart';
import 'package:poteu/presentation/screens/chapter/model/chapter_arguments.dart';
import 'package:poteu/presentation/screens/chapter/view/local_widgets/chapter_page_body/local_widgets/paragraph/paragraph_card_bottom_sheet.dart';
import 'package:poteu/presentation/screens/chapter/view/local_widgets/chapter_page_body/local_widgets/paragraph/paragraph_nft.dart';

import 'package:regulation_api/regulation_api.dart';

import 'package:poteu/presentation/screens/chapter/view/local_widgets/chapter_page_body/local_widgets/paragraph/paragraph_table.dart';

enum ParagraphClass { right, center, indent, none }

class ParagraphCard extends StatelessWidget {
  const ParagraphCard({
    Key? key,
    required this.ids,
    required this.paragraph,
    required this.orderNum,
  }) : super(key: key);
  final EditableParagraph paragraph;
  final List<int> ids;
  final int orderNum;

  Future<void> share(String text) async {
    await FlutterShare.share(
      title: 'Поделиться',
      text: text,
      // linkUrl: 'market://details?id=com.i_rm.poteu',
    );
  }

  @override
  Widget build(BuildContext context) {
    ParagraphClass pClass;
    switch (paragraph.editableParagraphClass) {
      case 'align_right':
        pClass = ParagraphClass.right;
        break;
      case 'align_right no-indent':
        pClass = ParagraphClass.right;
        break;
      case 'align_center':
        pClass = ParagraphClass.center;
        break;
      case 'indent':
        pClass = ParagraphClass.indent;
        break;
      default:
        pClass = ParagraphClass.none;
    }
    return BlocProvider(
        create: (context) => ParagraphCardCubit(
              regulationRepository: context.read<RegulationRepository>(),
            ),
        child: BlocBuilder<ParagraphCardCubit, ParagraphCardState>(
          builder: (context, state) {
            bool bottomBarExpanded = context.read<BottomBarCubit>().state;
            return (paragraph.isNFT || paragraph.isTable) || bottomBarExpanded
                ? Card(
                    elevation: 0,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    margin: EdgeInsets.zero,
                    child: pClass == ParagraphClass.indent
                        ? SizedBox(
                            height: 15,
                          )
                        : buildCard(context, pClass, bottomBarExpanded),
                  )
                : FocusedMenuHolder(
                    menuItems: [
                      FocusedMenuItem(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        title: Text("Редактировать"),
                        onPressed: () async {
                          TextEditingController _controller =
                              TextEditingController();
                          _controller.text = parseHtmlString(paragraph.content);
                          showDialog(
                              context: context,
                              builder: (_) => OrientationBuilder(
                                    builder: (BuildContext _,
                                            Orientation orientation) =>
                                        AlertDialog(
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      content: TextFormField(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        keyboardType: TextInputType.multiline,
                                        minLines: 2,
                                        maxLines: 25,
                                        controller: _controller,
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              await context
                                                  .read<SaveParagraphCubit>()
                                                  .saveEditedParagraph(
                                                      paragraph,
                                                      _controller.text);
                                              context.read<PageViewBloc>().add(
                                                  PageViewParagraphSavedEvent(
                                                      orderNum));
                                              Navigator.pop(_);
                                            },
                                            child: Text('Сохранить')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(_);
                                            },
                                            child: Text('Отменить')),
                                      ],
                                    ),
                                  ));
                        },
                        trailingIcon: Icon(
                          Icons.edit,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                      FocusedMenuItem(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          title: Text("Поделиться"),
                          onPressed: () async {
                            share(parseHtmlString(paragraph.content));
                          },
                          trailingIcon: Icon(
                            Icons.share,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          )),
                      FocusedMenuItem(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          title: Text("Прослушать"),
                          onPressed: () async {
                            List<String> _paragraphsContent = await context
                                .read<PageViewBloc>()
                                .paragraphsContent();
                            showModalBottomSheet(
                                isDismissible: false,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return ParagraphCardBottomSheet(
                                    content: paragraph.textToSpeech,
                                    paragraphs: _paragraphsContent,
                                  );
                                });
                          },
                          trailingIcon: Icon(
                            Icons.hearing_rounded,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          )),
                      FocusedMenuItem(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          title: Text("Заметки"),
                          onPressed: () {
                            context.read<BottomBarCubit>().expand();
                          },
                          trailingIcon: Icon(
                            Icons.note_alt_outlined,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          )),
                    ],
                    onPressed: () {},
                    bottomBorderColor: Colors.transparent,
                    openWithTap: true,
                    menuWidth: MediaQuery.of(context).size.width * 0.9,
                    blurBackgroundColor: Theme.of(context).focusColor,
                    menuOffset: 10,
                    blurSize: 1,
                    menuItemExtent: 60,
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      margin: EdgeInsets.zero,
                      child: pClass == ParagraphClass.indent
                          ? SizedBox(
                              height: 15,
                            )
                          : buildCard(context, pClass, bottomBarExpanded),
                    ),
                  );
          },
        ));
  }

  Container buildCard(
      BuildContext context, ParagraphClass pClass, bool bottomBarExpanded) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: pClass == ParagraphClass.none ? 16.0 : 2.0),
        child: paragraph.isNFT
            ? ParagraphNFT(content: paragraph.content)
            : paragraph.isTable
                ? ParagraphTable(
                    content: paragraph.content,
                    ids: ids,
                  )
                : BlocBuilder<FontCubit, FontState>(builder: (context, state) {
                    return bottomBarExpanded
                        ? SelectableTextWidget(
                            paragraph: paragraph,
                            orderNum: orderNum,
                            ids: ids,
                            pClass: pClass,
                            fontSize: realFontSize(state.fontSize),
                            fwIndex: fontWeightIndex(state.fontWeight),
                          )
                        : SelectableTextWidget(
                            paragraph: paragraph,
                            orderNum: orderNum,
                            isSelectable: false,
                            ids: ids,
                            pClass: pClass,
                            fontSize: realFontSize(state.fontSize),
                            fwIndex: fontWeightIndex(state.fontWeight),
                          );
                  }));
  }
}

class SelectableTextWidget extends StatelessWidget {
  const SelectableTextWidget({
    Key? key,
    required this.paragraph,
    this.isSelectable = true,
    required this.orderNum,
    required this.ids,
    required this.pClass,
    required this.fwIndex,
    required this.fontSize,
  }) : super(key: key);

  final EditableParagraph paragraph;
  final ParagraphClass pClass;
  final int orderNum, fwIndex;
  final double fontSize;
  final bool isSelectable;
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

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      paragraph.content,
      isSelectable: isSelectable,
      onSelectionChanged: (selection, cause) => context
          .read<SaveParagraphCubit>()
          .setOffset(selection.baseOffset, selection.extentOffset, orderNum,
              paragraph),
      textStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyText2!.color,
          fontSize: fontSize,
          fontWeight: FontWeight.values[fwIndex]),
      onTapUrl: (href) async {
        goTo(context, href);
        return false;
      },
      customStylesBuilder: pClass == ParagraphClass.none
          ? null
          : (element) {
              return {
                'text-align':
                    pClass == ParagraphClass.right ? 'right' : 'center'
              };
            },
    );
  }
}
