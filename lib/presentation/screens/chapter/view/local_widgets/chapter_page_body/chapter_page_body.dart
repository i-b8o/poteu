import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regulation_api/regulation_api.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:poteu/presentation/screens/chapter/bloc/bottom_bar/bottom_bar_cubit.dart';
import 'package:poteu/presentation/screens/chapter/bloc/links/links_bloc.dart';
import 'package:poteu/presentation/screens/chapter/view/local_widgets/chapter_page_body/local_widgets/chapter_page_body_header.dart';
import 'package:poteu/presentation/screens/chapter/view/local_widgets/chapter_page_body/local_widgets/paragraph/paragraph_card.dart';

class ChapterPageBody extends StatelessWidget {
  const ChapterPageBody({
    Key? key,
    required this.header,
    required this.paragraphs,
    required this.scrollTo,
    required this.itemScrollController,
  }) : super(key: key);

  final String header;
  final int scrollTo;
  final List<EditableParagraph> paragraphs;

  final ItemScrollController itemScrollController;

  ParagraphCard _buildParagraphCard(
      EditableParagraph paragraph, int orderNum, List<int> ids) {
    return ParagraphCard(
      ids: ids,
      paragraph: paragraph,
      orderNum: orderNum,
    );
  }

  void scrollToItem(int orderNum) {
    if (orderNum < 1) {
      return;
    }
    if (!itemScrollController.isAttached) {
      return;
    }
    itemScrollController.jumpTo(index: orderNum);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => scrollToItem(scrollTo - 1));

    List<int> ids = paragraphs.map((p) => p.id).toList();

    return BlocProvider(
      create: (context) => LinksBloc(),
      child: BlocBuilder<LinksBloc, LinksState>(
        builder: (context, state) {
          if (state is LinksLinkInState) {
            scrollToItem(state.index - 1);
          }
          return ScrollablePositionedList.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemScrollController: itemScrollController,
            itemCount: paragraphs.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ChapterPageBodyHeader(
                      header: header,
                      pClass: paragraphs[index].editableParagraphClass,
                    ),
                    _buildParagraphCard(paragraphs[index], index, ids),
                  ],
                );
              } else if ((index == (paragraphs.length - 1))) {
                return BlocBuilder<BottomBarCubit, bool>(
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildParagraphCard(paragraphs[index], index, ids),
                        state
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                              )
                            : Container()
                      ],
                    );
                  },
                );
              }
              return _buildParagraphCard(paragraphs[index], index, ids);
            },
          );
        },
      ),
    );
  }
}
