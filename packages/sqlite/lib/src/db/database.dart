import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_api/sqlite_api.dart';

class ParagraphsDB {
  static final ParagraphsDB instance = ParagraphsDB._init();
  static Database? _db;

  ParagraphsDB._init();

  Future<Database> get db async {
    if (_db != null) return _db!;

    _db = await _initDB('paragraphs.db');
    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const intType = 'INTEGER NOT NULL';
    const stringType = 'TEXT';

    await db.execute('''CREATE TABLE $tableNotes (
      ${EditedParagraphFields.id} $idType,
      ${EditedParagraphFields.paragraphId} $intType,
      ${EditedParagraphFields.chapterId} $intType,
      ${EditedParagraphFields.text} $stringType,
      ${EditedParagraphFields.edited} $intType,
      ${EditedParagraphFields.lastTouched} $intType
      )''');
  }

  Future<int> create(EditedParagraph paragraph) async {
    final _db = await instance.db;

    final _id = await _db.insert(tableNotes, paragraph.toJson());

    return _id;
  }

  Future<List<EditedParagraph>> readAllParagraphsForChapter(int chId) async {
    final _db = await instance.db;

    const _orderBy = '${EditedParagraphFields.id} ASC';

    final _result = await _db.query(tableNotes,
        where: '${EditedParagraphFields.chapterId} = ?',
        whereArgs: [chId],
        orderBy: _orderBy);

    return _result
        .map(
          (json) => EditedParagraph.fromJson(json),
        )
        .toList();
  }

  Future<List<EditedParagraph>> readAllParagraphs() async {
    final _db = await instance.db;

    const _orderBy = '${EditedParagraphFields.id} ASC';

    final _result = await _db.query(tableNotes, orderBy: _orderBy);

    return _result
        .map(
          (json) => EditedParagraph.fromJson(json),
        )
        .toList();
  }

  Future<int> update(EditedParagraph paragraph) async {
    final _db = await instance.db;

    return _db.update(tableNotes, paragraph.toJson(),
        where: '${EditedParagraphFields.id} = ?',
        whereArgs: [paragraph.paragraphId]);
  }

  Future<int> delete(int pId) async {
    final _db = await instance.db;

    return _db.delete(tableNotes,
        where: '${EditedParagraphFields.paragraphId} = ?', whereArgs: [pId]);
  }

  Future close() async {
    final db = await instance.db;

    db.close();
  }

  // Future<List<Paragraph>> readAllNotesForParagraph(int pId) async {
  //   final _db = await instance.db;

  //   const _orderBy = '${EditedParagraphFields.paragraphId} ASC';

  //   final _result = await _db.query(tableNotes,
  //       where: '${EditedParagraphFields.paragraphId} = ?',
  //       whereArgs: [pId],
  //       orderBy: _orderBy);

  //   return _result
  //       .map(
  //         (json) => Paragraph.fromJson(json),
  //       )
  //       .toList();
  // }

  // Future<List<Paragraph>> readAllParagraphs() async {
  //   final _db = await instance.db;

  //   const _orderBy = '${EditedParagraphFields.color} ASC';

  //   final _result = await _db.query(tableNotes, orderBy: _orderBy);

  //   return _result
  //       .map(
  //         (json) => Paragraph.fromJson(json),
  //       )
  //       .toList();
  // }
}
