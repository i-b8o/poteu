import 'package:regulation_api/regulation_api.dart';

class LocalStorageRegulationApi extends RegulationApi {
  final List<ChapterInfo> _tableOfContents;
  final String _regulationAbbreviation;

  static const THEME_KEY = 'theme_key';
  static const COLOR_PICKER_KEY = 'color_picker_key';

  LocalStorageRegulationApi()
      : _tableOfContents = Regulation.chapters.map((chapter) {
          return ChapterInfo(
              name: chapter.name,
              num: chapter.num,
              orderNum: chapter.orderNum,
              id: chapter.id);
        }).toList(),
        _regulationAbbreviation = Regulation.abbreviation;

  String getRegulationAbbreviation() {
    return _regulationAbbreviation;
  }

  List<ChapterInfo> getTableOfContents() {
    try {
      _tableOfContents.sort((a, b) => a.orderNum.compareTo(b.orderNum));
      return _tableOfContents;
    } catch (e) {
      throw Exception('Table of contents not found: $e');
    }
  }

  int countChapters() {
    try {
      return Regulation.chapters.length;
    } catch (e) {
      throw Exception('Chapters not found: $e');
    }
  }

  List<Paragraph> search(String query) {
    if (query.isEmpty) {
      return [];
    }

    query = query.toLowerCase().trim();
    List<Paragraph> _returnedList = [];
    List<Chapter> _chapters = Regulation.chapters;
    List<Paragraph> _paragraphs = [];
    for (final Chapter _chapter in _chapters) {
      _paragraphs = _chapter.paragraphs.where((paragraph) {
        String _content = paragraph.content.toLowerCase();
        // Remove HTML tags from a content
        _content = _content.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');

        return _content.contains(query);
      }).toList();
      _returnedList.addAll(_paragraphs);
    }

    return _returnedList;
  }

  List<Paragraph> getParagraphsByChapterOrderNum(int chapterID) {
    try {
      Chapter chapter = Regulation.chapters
          .where((chapter) => chapter.orderNum == chapterID)
          .first;

      return chapter.paragraphs;
    } catch (e) {
      throw Exception('Paragraph not found: $e');
    }
  }

  int getChapterIdByOrderNum(int chapterOrderNum) {
    try {
      Chapter chapter = Regulation.chapters
          .where((chapter) => chapter.orderNum == (chapterOrderNum + 1))
          .first;
      chapter.paragraphs.forEach((p) {});
      return chapter.id;
    } catch (e) {
      throw Exception('Chapter not found: $e');
    }
  }

  String getChapterNameByOrderNum(int chapterOrderNum) {
    try {
      Chapter chapter = Regulation.chapters
          .where((chapter) => chapter.orderNum == chapterOrderNum)
          .first;
      String result = chapter.num.length > 0
          ? '${chapter.num}. ${chapter.name}'
          : chapter.name;
      return result;
    } catch (e) {
      throw Exception('Chapter name not found: $e');
    }
  }

  String getChapterNameByID(int chapterID) {
    try {
      Chapter chapter =
          Regulation.chapters.where((chapter) => chapter.id == chapterID).first;
      String result = chapter.num.length > 0
          ? '${chapter.num}. ${chapter.name}'
          : chapter.name;
      return result;
    } catch (e) {
      throw Exception('Chapter name not found: $e');
    }
  }

  String getRegulationName() {
    try {
      return Regulation.name;
    } catch (e) {
      throw Exception('Regulation Name not found: $e');
    }
  }

  GoTo? getGoTo(int? chapterID, paragraphID) {
    print('Here $chapterID $paragraphID');
    try {
      if (paragraphID != null) {
        
        List<Link> links =
            AllLinks.links.where((l) => l.id == paragraphID).toList();
        if (links.isEmpty) {
          return null;
        }
        Link link = links.first;


        return GoTo(
          regId: link.rid,
          chapterOrderNum: link.chapterNum,
          paragraphOrderNum: link.paragraphNum,
        );
      }
      if (chapterID != null) {
        
        List<Chapter> chapters =
            Regulation.chapters.where((c) => c.id == chapterID).toList();
        if (chapters.length == 0){
          return null;
        }
        return GoTo(
          regId: Regulation.id,
          chapterOrderNum: chapters.first.orderNum,
          paragraphOrderNum: 0,
        );
      }
      return null;
    } catch (e) {
      throw Exception('Links not found: $e');
    }
  }

  @override
  List<int> getChapterAndParagraphOrderNums(int chapterID, paragraphID) {
    try {
      List<int> result = [];
      Chapter chapter =
          Regulation.chapters.where((chapter) => chapter.id == chapterID).first;
      result.add(chapter.orderNum);
      Paragraph paragraph =
          chapter.paragraphs.where((p) => p.id == paragraphID).first;
      result.add(paragraph.num);
      return result;
    } catch (e) {
      throw Exception(
          'Chapter $chapterID and paragraph $paragraphID  not found: $e');
    }
  }
}
