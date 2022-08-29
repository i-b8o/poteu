import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../chapter/model/chapter_arguments.dart';
import '../table_of_contents/bloc/table_of_contents/table_of_contents_bloc.dart';
import '../table_of_contents/model/edited_paragraph_info.dart';
import 'bloc/notes/notes_cubit.dart';
import 'local_widgets/app_bar/notes_list_app_bar.dart';

class NotesListPage extends StatelessWidget {
  const NotesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(Theme.of(context).appBarTheme.elevation!),
        child: NotesListAppBar(),
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesLoaded && state.editedParagraphs.length > 0) {
            double _width = MediaQuery.of(context).size.width;
            List<EditedParagraphInfo> _bookMarks = state.editedParagraphs;
            return ListView.builder(
                itemCount: _bookMarks.length,
                itemBuilder: (context, index) {
                  EditedParagraphInfo _bookMark = _bookMarks[index];
                  return Card(
                    elevation: 0,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    margin: EdgeInsets.zero,
                    shape: Border(
                      bottom: BorderSide(
                          width: 1.0, color: Theme.of(context).shadowColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(_width * 0.04, _width * 0.06,
                          _width * 0.075, _width * 0.05),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  List<int> chapterAndParagraphOrderNums =
                                      context
                                          .read<NotesCubit>()
                                          .getChapterAndParagraphOrderNums(
                                              _bookMark.chapterID,
                                              _bookMark.paragraphID);

                                  ChapterArguments args = ChapterArguments(
                                      chapterOrderNum:
                                          chapterAndParagraphOrderNums[0],
                                      totalChapters: context
                                          .read<TableOfContentsBloc>()
                                          .chapters
                                          .length,
                                      scrollTo:
                                          chapterAndParagraphOrderNums[1]);
                                  Navigator.popAndPushNamed(context, '/chapter',
                                      arguments: args);
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.bookmark,
                                          color: _bookMark.link.color,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                        ),
                                        SizedBox(
                                          width: _width * 0.04,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          child: Text(
                                            '${_bookMark.regulationAbbriviation}. ${_bookMark.chapterName}',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: _width * 0.045,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: _width * 0.04,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: _width * 0.1,
                                        ),
                                        SizedBox(
                                          width: _width * 0.65,
                                          child: Text(
                                            _bookMark.link.text,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: _width * 0.03,
                                                color: Theme.of(context)
                                                    .appBarTheme
                                                    .toolbarTextStyle!
                                                    .color,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context
                                    .read<NotesCubit>()
                                    .delete(_bookMark),
                                child: Icon(
                                  Icons.close,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: Text("У вас пока нет заметок"),
          );
        },
      ),
    );
  }
}
