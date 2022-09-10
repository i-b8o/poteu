import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poteu/bloc/regulation/regulation_cubit.dart';

import 'package:poteu/bloc/speak/speak_cubit.dart';
import 'package:poteu/repository/regulation_repository.dart';
import 'package:poteu/presentation/router/app_router.dart';
import 'package:poteu/presentation/theme/theme.dart';

import 'package:poteu/presentation/screens/chapter/bloc/colors/colors_cubit.dart';
import 'package:poteu/presentation/screens/navigation_drawer/cubit/font/font_cubit.dart';
import 'package:poteu/presentation/screens/navigation_drawer/cubit/sound/sound_cubit.dart';
import 'package:poteu/presentation/screens/notes_list/bloc/notes/notes_cubit.dart';
import 'package:poteu/presentation/screens/table_of_contents/bloc/table_of_contents/table_of_contents_bloc.dart';
import 'package:poteu/presentation/screens/app/bloc/app_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.regulationRepository}) : super(key: key);

  final RegulationRepository regulationRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: regulationRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);
  static final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegulationCubit(
            regulationRepository: context.read<RegulationRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => TableOfContentsBloc(
            regulationRepository: context.read<RegulationRepository>(),
          ),
        ),
        BlocProvider(
            create: (_) => AppBloc(
                  regulationRepository: context.read<RegulationRepository>(),
                )..add(AppThemeInitialEvent())),
        BlocProvider(
          create: (context) => NotesCubit(
            regulationRepository: context.read<RegulationRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => SoundCubit(
            regulationRepository: context.read<RegulationRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => FontCubit(
            regulationRepository: context.read<RegulationRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ColorsCubit(
            regulationRepository: context.read<RegulationRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => SpeakCubit(
            regulationRepository: context.read<RegulationRepository>(),
          ),
        )
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state is AppThemeState && state.isDark
                ? FlutterRegulationTheme.dark
                : FlutterRegulationTheme.light,
            darkTheme: FlutterRegulationTheme.dark,
            onGenerateRoute: _appRouter.onGenerateRoute,
            initialRoute: '/',
          );
        },
      ),
    );
  }
}
