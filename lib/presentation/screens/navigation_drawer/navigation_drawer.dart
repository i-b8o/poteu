import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolling_switch/rolling_switch.dart';

import 'package:poteu/presentation/screens/app/bloc/app_bloc.dart';
import 'package:poteu/presentation/screens/navigation_drawer/cubit/expansion/expansion_cubit.dart';
import 'package:poteu/presentation/screens/navigation_drawer/local_widgets/font_menu_item.dart';
import 'package:poteu/presentation/screens/navigation_drawer/local_widgets/notes_menu_item.dart';
import 'package:poteu/presentation/screens/navigation_drawer/local_widgets/sound_menu_item/sound_menu_item.dart';

// TODO add in theme
class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        return MediaQuery.of(context).orientation == Orientation.portrait
            ? Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: Drawer(
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(30)),
                  ),
                  backgroundColor:
                      Theme.of(context).navigationRailTheme.backgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocProvider(
                          create: (context) => ExpansionCubit(),
                          child: BlocBuilder<ExpansionCubit, int>(
                            builder: (context, state) {
                              return Expanded(
                                child: ListView.builder(
                                  key: Key(
                                      'builder ${state.toString()}'), //attention
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return NotesMenuItem();
                                    } else if (index == 1) {
                                      return FontMenuItem(index: 1);
                                    }
                                    return SoundMenuItem(index: 2);
                                    // if (index == 0) {
                                    //   return NotesMenuItem();
                                    // } else if (index == 1) {
                                    //   return DocsMenuItem(index: 0);
                                    // } else if (index == 2) {
                                    //   return FontMenuItem(index: 1);
                                    // }
                                    // return SoundMenuItem(index: 2);
                                  },
                                ),
                              );
                            },
                          )),
                      BlocBuilder<AppBloc, AppState>(
                        builder: (context, state) {
                          bool _isDark = false;
                          if (state is AppThemeState && state.isDark) {
                            _isDark = true;
                          }
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: ListTile(
                              leading: Icon(
                                _isDark ? Icons.dark_mode : Icons.sunny,
                                size: 35,
                                color: Theme.of(context).indicatorColor,
                              ),
                              trailing: Transform.scale(
                                scale: 0.7,
                                child: RollingSwitch.widget(
                                    initialState: _isDark,
                                    onChanged: (bool state) {
                                      context
                                          .read<AppBloc>()
                                          .add(AppSetThemeEvent(!_isDark));
                                    },
                                    rollingInfoRight: RollingWidgetInfo(
                                      icon: Container(
                                        decoration: new BoxDecoration(
                                          color: Color(0xFFff9500),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      backgroundColor: Color(0xFF191c1e),
                                      text: Text('ON'),
                                    ),
                                    rollingInfoLeft: RollingWidgetInfo(
                                      icon: Container(
                                        decoration: new BoxDecoration(
                                          color: Color(0xFFff9500),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      backgroundColor: Color(0xFFfdecd9),
                                      text: Text(
                                        'OFF',
                                        style:
                                            TextStyle(color: Color(0xFF5a5a5a)),
                                      ),
                                    )),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
