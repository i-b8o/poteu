import 'models/models.dart';

abstract class RegulationApi {
  const RegulationApi();

  String getRegulationAbbreviation();

  List<ChapterInfo> getTableOfContents();

  List<Paragraph> getParagraphsByChapterOrderNum(int chapterOrderNum);

  List<Paragraph> search(String query);

  List<int> getChapterAndParagraphOrderNums(int chapterID, paragraphID);

  String getChapterNameByOrderNum(int chapterOrderNum);

  String getChapterNameByID(int chapterID);

  String getRegulationName();

  GoTo? getGoTo(int id);
}
