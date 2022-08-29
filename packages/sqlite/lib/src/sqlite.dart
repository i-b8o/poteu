import 'package:sqlite_api/sqlite_api.dart';

import 'db/database.dart';

class Sqlite extends SqliteApi {
  Future<List<EditedParagraph>> getEditedParagraphsForChapter(int cId) async {
    try {
      List<EditedParagraph> _paragraps =
          await ParagraphsDB.instance.readAllParagraphsForChapter(cId);

      return _paragraps;
    } on Exception catch (e) {
      throw Exception('Chapter ID $cId not found: $e');
    } catch (e) {
      throw Exception('Chapter ID $cId not found, error: $e');
    }
  }

  Future<void> deleteParagraph(int id) async {
    try {
      await ParagraphsDB.instance.delete(id);
    } on Exception catch (e) {
      throw Exception('The paragraph $id not deleted: $e');
    } catch (e) {
      throw Exception('The paragraph $id not deleted, error: $e');
    }
  }

  Future<void> saveParagraph(EditedParagraph paragraph) async {
    try {
      await ParagraphsDB.instance.delete(paragraph.paragraphId);
      await ParagraphsDB.instance.create(paragraph);
    } on Exception catch (e) {
      throw Exception('The paragraph ${paragraph.paragraphId} not saved: $e');
    } catch (e) {
      throw Exception(
          'The paragraph ${paragraph.paragraphId} not saved, error: $e');
    }
  }

  @override
  Future<List<EditedParagraph>> getAllEditedParagraphs() async {
    try {
      List<EditedParagraph> _paragraps =
          await ParagraphsDB.instance.readAllParagraphs();

      return _paragraps;
    } on Exception catch (e) {
      throw Exception('Edited paragraphs not found: $e');
    } catch (e) {
      throw Exception('Edited paragraphs not found, error: $e');
    }
  }
}
