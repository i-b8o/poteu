import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:local_storage_regulation_api/local_storage_regulation_api.dart';
import 'package:poteu/sentryurl.dart';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp/sp.dart';
import 'package:sqlite/sqlite.dart';
import 'package:tts/tts.dart';

import 'presentation/screens/app/app.dart';
import 'repository/regulation_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));

  final regulationApi = LocalStorageRegulationApi();
  final sp = SP(
    plugin: await SharedPreferences.getInstance(),
  );
  final sqlite = Sqlite();
  final tts = TTS(plugin: FlutterTts());
  final regulationRepository = RegulationRepository(
      regulationApi: regulationApi, spApi: sp, sqliteApi: sqlite, ttsApi: tts);

  await SentryFlutter.init(
    (options) => options.dsn = sentryUrl,
    appRunner: () => runApp(
      App(regulationRepository: regulationRepository),
    ),
  );
}
