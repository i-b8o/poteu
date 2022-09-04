import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/sound/sound_cubit.dart';
import 'voice_btn.dart';

class VoiceItem extends StatelessWidget {
  const VoiceItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundCubit, SoundState>(
      builder: (context, state) {
        List<String>? _voices = context.read<SoundCubit>().voices;

        return _voices == null || state.voice == ''
            ? Container()
            : GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        List<DropdownMenuItem<String>> _items = _voices
                            .map((v) => DropdownMenuItem(
                                  value: v,
                                  child: Text(v),
                                ))
                            .toList();
                        return AlertDialog(
                          backgroundColor: Theme.of(context)
                              .navigationRailTheme
                              .backgroundColor,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              VoiceBtn(
                                color: Color(0xFF5ec8ad),
                              ),
                              BlocBuilder<SoundCubit, SoundState>(
                                buildWhen: (previous, current) =>
                                    previous.voice != current.voice,
                                builder: (context, state) {
                                  try {
                                    return DropdownButton(
                                        items: _items,
                                        value: state.voice,
                                        style: Theme.of(context)
                                            .navigationRailTheme
                                            .unselectedLabelTextStyle,
                                        dropdownColor: Theme.of(context)
                                            .navigationRailTheme
                                            .backgroundColor,
                                        onChanged: (String? value) => context
                                            .read<SoundCubit>()
                                            .setVoice(value ?? ""));
                                  } catch (e) {
                                    return Container();
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  color: Theme.of(context).navigationRailTheme.backgroundColor,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Голос',
                        style: TextStyle(
                          color: Theme.of(context)
                              .navigationRailTheme
                              .unselectedLabelTextStyle!
                              .color,
                        ),
                      ),
                      Text(state.voice),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
