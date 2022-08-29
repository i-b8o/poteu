import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/sound/sound_cubit.dart';

class VoiceBtn extends StatelessWidget {
  const VoiceBtn({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SoundCubit, SoundState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => state.speaking
              ? context.read<SoundCubit>().stop()
              : context.read<SoundCubit>().speakRand(),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.12,
            height: MediaQuery.of(context).size.width * 0.12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: new Icon(
              state.speaking
                  ? Icons.volume_off_outlined
                  : Icons.volume_up_outlined,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
