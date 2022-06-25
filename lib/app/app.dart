import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poteu_local_storage_repository/poteu_local_storage_repository.dart';

import '../views/main_page/main_page.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.poteuLocalStorageRepository})
      : super(key: key);

  final PoteuLocalStorageRepository poteuLocalStorageRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: poteuLocalStorageRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: const MainPage(),
      );
}
