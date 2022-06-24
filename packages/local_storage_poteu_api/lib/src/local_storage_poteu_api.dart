import 'dart:convert';

import 'package:local_storage_poteu_api/local_storage_poteu_api.dart';
import 'package:poteu_api/poteu_api.dart';
import 'package:rxdart/rxdart.dart';

/// {@template local_storage_poteu_api}
/// A Flutter implementation of the [PoteuApi] that uses local storage.
/// {@endtemplate}
class LocalStoragePoteuApi extends PoteuApi {
  /// {@macro local_storage_poteu_api}
  LocalStoragePoteuApi(
      {required SharedPreferences plugin, required String collectionKey})
      : _plugin = plugin,
        _collectionKey = collectionKey {
    _init();
  }
  final String _collectionKey;
  final SharedPreferences _plugin;
  final _editedStreamController =
      BehaviorSubject<List<Edited>>.seeded(const []);

  String? _getValue(String key) => _plugin.getString(key);

  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final editedJson = _getValue(_collectionKey);
    if (editedJson != null) {
      final todos = List<Map>.from(json.decode(editedJson) as List)
          .map((jsonMap) => Edited.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _editedStreamController.add(todos);
    } else {
      _editedStreamController.add(const []);
    }
  }

  @override
  Stream<List<Edited>> getEdited() =>
      _editedStreamController.asBroadcastStream();

  @override
  Future<void> saveEdited(Edited edited) {
    final editeds = [..._editedStreamController.value];
    final todoIndex = editeds.indexWhere((e) => e.id == edited.id);
    if (todoIndex >= 0) {
      editeds[todoIndex] = edited;
    } else {
      editeds.add(edited);
    }

    _editedStreamController.add(editeds);
    return _setValue(_collectionKey, json.encode(editeds));
  }
}
