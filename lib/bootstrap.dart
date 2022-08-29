// import 'dart:async';
// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:regulation_api/regulation_api.dart';


// import 'package:sp_api/sp_api.dart';
// import 'package:sqlite_api/sqlite_api.dart';
// import 'package:tts_api/tts_api.dart';

// import 'presentation/screens/app/app.dart';
// import 'presentation/screens/app/app_bloc_observer.dart';
// import 'repository/regulation_repository.dart';

// void bootstrap(
//     {required RegulationApi regulationApi,
//     required SPApi spApi,
//     required SqliteApi sqliteApi,
//     required TTSApi ttsApi}) {
//   FlutterError.onError = (details) {
//     log(details.exceptionAsString(), stackTrace: details.stack);
//   };

//   final regulationRepository = RegulationRepository(
//       regulationApi: regulationApi,
//       spApi: spApi,
//       sqliteApi: sqliteApi,
//       ttsApi: ttsApi);

//   runZonedGuarded(
//     () async {
//       await BlocOverrides.runZoned(
//         () async => runApp(
//           App(regulationRepository: regulationRepository),
//         ),
//         blocObserver: AppBlocObserver(),
//       );
//     },
//     (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
//   );
// }
