import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_poteu_api/local_storage_poteu_api.dart';

import 'package:poteu_local_storage_repository/poteu_local_storage_repository.dart';
import 'bloc/bloc.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final poteuApi = LocalStoragePoteuApi();

  bootstrap(poteuApi: poteuApi);
}

Future<void> bootstrap({required PoteuApi poteuApi}) async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // runApp(Provider(create: (_) => Bloc(), child: const App()));
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final poteuLocalStorageRepository =
      PoteuLocalStorageRepository(poteuApi: poteuApi);

  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(Provider(
          create: (_) => MyBloc(),
          child: App(
            poteuLocalStorageRepository: poteuLocalStorageRepository,
          ),
        )),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
