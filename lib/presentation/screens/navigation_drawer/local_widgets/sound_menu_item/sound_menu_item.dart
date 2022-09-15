import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poteu/presentation/screens/navigation_drawer/cubit/sound/sound_cubit.dart';
import 'package:poteu/presentation/screens/navigation_drawer/model/sound_settings.dart';
import 'package:poteu/presentation/screens/navigation_drawer/local_widgets/local_widgets/menu_sub_Item.dart';
import 'package:poteu/presentation/screens/navigation_drawer/local_widgets/local_widgets/nav_drawer_menu_item.dart';
import 'package:poteu/presentation/screens/navigation_drawer/local_widgets/sound_menu_item/local_widgets/sound_slider.dart';
import 'package:poteu/presentation/screens/navigation_drawer/local_widgets/sound_menu_item/local_widgets/voice_item.dart';

class SoundMenuItem extends StatelessWidget {
  const SoundMenuItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return NavDrawerMenuItem(
      leadingIconData: Icons.volume_up_outlined,
      title: 'Звук',
      index: index,
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: BlocBuilder<SoundCubit, SoundState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    MenuSubItem(
                      value: state.volume,
                      leading: 'Громкость',
                      alertDialog: AlertDialog(
                          backgroundColor: Theme.of(context)
                              .navigationRailTheme
                              .backgroundColor,
                          content: BlocBuilder<SoundCubit, SoundState>(
                            builder: (context, state) {
                              return SoundSlider(
                                title: 'Громкость',
                                text: '${(state.volume * 100).round()}%',
                                color: Color(0xFF552cf6),
                                value: state.volume,
                                onIconTap: () async =>
                                    context.read<SoundCubit>().speakRand(),
                                onChanged: (double value) async {
                                  context.read<SoundCubit>().setSettings(
                                      SoundSettings(volume: value));
                                },
                                onChangeEnd: (value) async => context
                                    .read<SoundCubit>()
                                    .saveVolume(value),
                              );
                            },
                          )),
                    ),
                    MenuSubItem(
                      leading: 'Скорость',
                      value: state.speed,
                      alertDialog: AlertDialog(
                          backgroundColor: Theme.of(context)
                              .navigationRailTheme
                              .backgroundColor,
                          content: BlocBuilder<SoundCubit, SoundState>(
                            builder: (context, state) {
                              return SoundSlider(
                                title: 'Скорость',
                                text: '${(state.speed * 100).round()}%',
                                // icon: Icons.volume_up_outlined,

                                color: Color(0xFF475df9),
                                value: state.speed,
                                onIconTap: () async =>
                                    context.read<SoundCubit>().speakRand(),
                                onChanged: (double value) async {
                                  context
                                      .read<SoundCubit>()
                                      .setSettings(SoundSettings(speed: value));
                                },
                                onChangeEnd: (value) async =>
                                    context.read<SoundCubit>().saveSpeed(value),
                              );
                            },
                          )),
                    ),
                    MenuSubItem(
                      leading: 'Высота',
                      value: state.pitch,
                      alertDialog: AlertDialog(
                          backgroundColor: Theme.of(context)
                              .navigationRailTheme
                              .backgroundColor,
                          content: BlocBuilder<SoundCubit, SoundState>(
                            builder: (context, state) {
                              return SoundSlider(
                                title: 'Высота',
                                text: '${(state.pitch * 100).round()}%',
                                color: Color(0xFF5aa9f7),
                                value: state.pitch,
                                onIconTap: () async =>
                                    context.read<SoundCubit>().speakRand(),
                                onChanged: (double value) async {
                                  context
                                      .read<SoundCubit>()
                                      .setSettings(SoundSettings(pitch: value));
                                },
                                onChangeEnd: (value) async =>
                                    context.read<SoundCubit>().savePitch(value),
                              );
                            },
                          )),
                    ),
                    VoiceItem()
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
