import 'dart:io';
import 'package:hive/hive.dart';

import 'package:local_storage_poteu_api/local_storage_poteu_api.dart';
import 'package:poteu_api/poteu_api.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

/// {@template local_storage_poteu_api}
/// A Flutter implementation of the [PoteuApi] that uses local storage.
/// {@endtemplate}
class LocalStoragePoteuApi extends PoteuApi {
  /// {@macro local_storage_poteu_api}
  LocalStoragePoteuApi() {
    _init();
  }

  Future<void> _init() async {
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(DocAdapter());
  }

  @override
  Future<Doc> getDoc(String abbreviation) async {
    final box = await Hive.openBox<Doc>('docs');
    Doc _doc = box.values.lastWhere((doc) => doc.abbreviation == abbreviation);
    return _doc;
  }

  @override
  Future<void> saveDoc(Doc doc) async {
    var box = await Hive.openBox<Doc>('docs');
    box.add(doc);
  }
}
