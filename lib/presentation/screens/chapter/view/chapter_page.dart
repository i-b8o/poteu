import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../bloc/speak/speak_cubit.dart';
import '../../../../repository/regulation_repository.dart';
import '../../../widgets/regulation_app_bar.dart';
import '../bloc/bottom_bar/bottom_bar_cubit.dart';
import '../bloc/page_view/bloc.dart';
import '../bloc/save_paragraph/save_paragraph_cubit.dart';
import '../model/chapter_arguments.dart';

import '../model/span.dart';
import 'local_widgets/chapter_app_bar/chapter_app_bar.dart';
import 'local_widgets/chapter_bottom_bar/bottom_bar_black/bottom_bar_black.dart';
import 'local_widgets/chapter_bottom_bar/bottom_bar_white/bottom_bar_white.dart';
import 'local_widgets/chapter_page_body/chapter_page_body.dart';

class ChapterPageView extends StatelessWidget {
  const ChapterPageView({Key? key, required this.args}) : super(key: key);
  final ChapterArguments args;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (blocContext) => PageViewBloc(
        regulationRepository: context.read<RegulationRepository>(),
        chapterOrderNum: args.chapterOrderNum,
        appBarOrderNumController:
            TextEditingController(text: args.chapterOrderNum.toString()),
        pageController: PageController(
          initialPage: args.chapterOrderNum - 1,
        ),
        totalChapters: args.totalChapters,
        paragraphOrderNum: args.scrollTo,
      )..add(PageViewLoadParagraphsEvent(args.scrollTo)),
      child: BlocBuilder<SpeakCubit, bool>(
        builder: (context, state) {
          return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: state
                  ? FloatingActionButton(
                      child: Icon(Icons.stop),
                      onPressed: () {
                        context.read<SpeakCubit>().stop();
                      },
                    )
                  : null,
              resizeToAvoidBottomInset: false,
              appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(Theme.of(context).appBarTheme.elevation!),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                    ),
                    child: BlocBuilder<PageViewBloc, PageViewInitState>(
                      buildWhen: (previousState, state) {
                        return previousState != state;
                      },
                      builder: (context, state) {
                        if (state is PageViewChapterLoadedState) {
                          return RegulationAppBar(
                            child: ChapterAppBar(
                              controller: state.appBarOrderNumController,
                              totalChapters: state.totalChapters,
                              pageController: state.pageController,
                            ),
                          );
                        }
                        return RegulationAppBar(child: Container());
                      },
                    ),
                  )),
              body: BlocBuilder<PageViewBloc, PageViewInitState>(
                buildWhen: (previous, current) =>
                    previous.changed != current.changed,
                builder: (context, state) {
                  if (state is PageViewChapterLoadedState) {
                    return OrientationBuilder(
                      builder: (BuildContext context, Orientation orientation) {
                        double _bottomBarBlackHeight =
                            orientation == Orientation.portrait
                                ? _height * 0.4
                                : _height * 0.6;
                        double _bottomBarWhiteHeight =
                            orientation == Orientation.portrait
                                ? _height * 0.32
                                : _height * 0.48;
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (bottomBarContext) => BottomBarCubit(),
                            ),
                            BlocProvider(
                              create: (context) => SaveParagraphCubit(
                                  regulationRepository:
                                      context.read<RegulationRepository>(),
                                  paragraph: state.paragraphs.first),
                            ),
                          ],
                          child: BlocListener<SaveParagraphCubit,
                              SaveParagraphState>(
                            listener: (context, state) {
                              if (state is SaveParagraphEmptySelected) {
                                String text = state.tag == Tag.c
                                    ? 'Вы не выделили параграф, в котором собираетесь удалить заметки'
                                    : state.tag == Tag.m
                                        ? 'Вы не выделили участок параграфа, который собираетесь выделить.'
                                        : 'Вы не выделили участок параграфа, который собираетесь подчеркнуть.';
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(text)));
                              }
                            },
                            child: BlocBuilder<BottomBarCubit, bool>(
                              builder: (bottomBarContext, bottomBarstate) {
                                return Stack(children: [
                                  PageView.builder(
                                      controller: state.pageController,
                                      itemCount: state.totalChapters,
                                      onPageChanged: (index) {
                                        context.read<PageViewBloc>().add(
                                            PageViewChapterChangedEvent(
                                                index + 1));
                                      },
                                      itemBuilder: ((context, index) {
                                        return ChapterPageBody(
                                          scrollTo: state.paragraphOrderNum,
                                          header: state.chapterName,
                                          paragraphs: state.paragraphs, itemScrollController:  ItemScrollController(),
                                        );
                                      })),
                                  AnimatedPositioned(
                                    duration: Duration(milliseconds: 500),
                                    bottom: bottomBarstate
                                        ? 0
                                        : -_bottomBarBlackHeight,
                                    child: Container(
                                      height: _bottomBarBlackHeight,
                                      width: MediaQuery.of(context).size.width,
                                      child: Stack(
                                        children: [
                                          BottomBarBlack(
                                            iconSize: orientation ==
                                                    Orientation.portrait
                                                ? _height * 0.025
                                                : _height * 0.04,
                                            height: _bottomBarBlackHeight,
                                          ),
                                          BottomBarWhite(
                                            height: _bottomBarWhiteHeight,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ]);
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ));
        },
      ),
    );
  }
}
