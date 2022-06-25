import 'package:poteu_api/poteu_api.dart';

/// {@template docs_repository}
/// A repository that handles doc related requests.
/// {@endtemplate}
class PoteuLocalStorageRepository {
  /// {@macro poteu_local_storage_repository}
  const PoteuLocalStorageRepository({
    required PoteuApi poteuApi,
  }) : _poteuApi = poteuApi;

  final PoteuApi _poteuApi;

  /// Saves a [Doc].
  ///
  /// If a [Doc] with the same id already exists, it will be replaced.
  Future<void> saveDoc(Doc doc) => _poteuApi.saveDoc(doc);

  /// Provides a Doc.
  Future<Doc> getDoc(String abbreviation) => _poteuApi.getDoc(abbreviation);
}
