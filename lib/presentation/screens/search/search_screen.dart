import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../chapter/model/chapter_arguments.dart';
import '../notes_list/bloc/notes/notes_cubit.dart';
import '../table_of_contents/bloc/table_of_contents/table_of_contents_bloc.dart';
import 'local_widgets/search_screen_app_bar.dart';
import 'model/editable_content_paragraph.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key, required this.paragraphs}) : super(key: key);
  final List<EditableContentParagraph> paragraphs;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(Theme.of(context).appBarTheme.elevation!),
        child: SearchScreenAppBar(),
      ),
      body: (paragraphs.length == 0)
          ? Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Text(
                  'По вашему запросу ничего не найдено.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            )
          : ListView.builder(
              itemCount: paragraphs.length,
              itemBuilder: (context, index) {
                EditableContentParagraph _paragraph = paragraphs[index];
                return Card(
                  elevation: 0,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  margin: EdgeInsets.zero,
                  shape: Border(
                    bottom: BorderSide(
                        width: 1.0, color: Theme.of(context).shadowColor),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(_width * 0.01, _width * 0.06,
                        _width * 0.01, _width * 0.05),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                List<int> chapterAndParagraphOrderNums = context
                                    .read<NotesCubit>()
                                    .getChapterAndParagraphOrderNums(
                                        _paragraph.paragraph.chapterID,
                                        _paragraph.paragraph.id);

                                ChapterArguments args = ChapterArguments(
                                    chapterOrderNum:
                                        chapterAndParagraphOrderNums[0],
                                    totalChapters: context
                                        .read<TableOfContentsBloc>()
                                        .chapters
                                        .length,
                                    scrollTo: chapterAndParagraphOrderNums[1]);
                                Navigator.pushNamed(context, '/chapter',
                                    arguments: args);
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: _width * 0.05,
                                  ),
                                  SizedBox(
                                    width: _width * 0.85,
                                    child: HtmlWidget(
                                      _paragraph.content,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
