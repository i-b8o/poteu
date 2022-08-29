import 'models/edited_paragraph.dart';

abstract class SqliteApi {
  const SqliteApi();

  Future<void> saveParagraph(EditedParagraph paragraph);

  Future<List<EditedParagraph>> getEditedParagraphsForChapter(int cId);

  Future<List<EditedParagraph>> getAllEditedParagraphs();

  Future<void> deleteParagraph(int id);

  
}
