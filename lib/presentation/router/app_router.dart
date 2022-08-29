import 'package:flutter/material.dart';

import '../screens/chapter/model/chapter_arguments.dart';
import '../screens/chapter/view/chapter_page.dart';

import '../screens/notes_list/notes_list_page.dart';
import '../screens/search/model/editable_content_paragraph.dart';
import '../screens/search/search_screen.dart';
import '../screens/table_of_contents/view/table_of_contents.dart';

abstract class AppRouteNames {
  static const contents = '/';
  static const chapter = '/chapter';
  static const notesList = '/notesList';
  static const searchScreen = '/searchScreen';
}

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouteNames.contents:
        return MaterialPageRoute(builder: (_) => TableOfContentsPage());
        // ignore: dead_code
        break;
      case AppRouteNames.notesList:
        return MaterialPageRoute(builder: (_) => NotesListPage());
        // ignore: dead_code
        break;
      case AppRouteNames.chapter:
        final arguments = routeSettings.arguments;
        final chapterArguments = arguments is ChapterArguments
            ? arguments
            : ChapterArguments(
                totalChapters: 0, chapterOrderNum: 0, scrollTo: 0);
        return MaterialPageRoute(
            builder: (_) => ChapterPageView(args: chapterArguments));
        // ignore: dead_code
        break;

      case AppRouteNames.searchScreen:
        final arguments = routeSettings.arguments;
        List<EditableContentParagraph> chapterArguments =
            arguments is List<EditableContentParagraph> ? arguments : [];
        return MaterialPageRoute(
            builder: (_) => SearchScreen(
                  paragraphs: chapterArguments,
                ));
        // ignore: dead_code
        break;

      default:
        return null;
    }
  }
}
