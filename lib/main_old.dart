// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:regulations_local_storage/regulations_local_storage.dart';
// import 'package:regulations_local_storage_repository/regulations_local_storage_repository.dart';

// import 'bloc/bloc.dart';
// import 'package:provider/provider.dart';

// import 'app/app.dart';
// import 'app/app_bloc_observer.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final regulationsLocalStorageApi = RegulationsLocalStorage();

//   bootstrap(regulationsLocalStorage: regulationsLocalStorageApi);
// }

// Future<void> bootstrap(
//     {required RegulationsLocalStorage regulationsLocalStorage}) async {
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);

//   // runApp(Provider(create: (_) => Bloc(), child: const App()));
//   FlutterError.onError = (details) {
//     log(details.exceptionAsString(), stackTrace: details.stack);
//   };

//   final regulationsLocalStorageRepository = RegulationsLocalStorageRepository(
//       regulationsLocalStorageApi: regulationsLocalStorage);

//   runZonedGuarded(
//     () async {
//       await BlocOverrides.runZoned(
//         () async => runApp(Provider(
//           create: (_) => MyBloc(),
//           child: App(
//             regulationsLocalStorageRepository:
//                 regulationsLocalStorageRepository,
//           ),
//         )),
//         blocObserver: AppBlocObserver(),
//       );
//     },
//     (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
//   );
// }
