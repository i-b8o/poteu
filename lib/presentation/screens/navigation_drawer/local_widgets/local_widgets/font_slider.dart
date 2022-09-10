import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poteu/utils/font.dart';
import 'package:poteu/presentation/screens/navigation_drawer/cubit/font/font_cubit.dart';

class FontSlider extends StatelessWidget {
  const FontSlider({
    Key? key,
    required this.title,
    required this.color,
    required this.onChangeEnd,
    required this.onChanged,
    required this.text,
    required this.value,
  }) : super(key: key);
  final String title;
  final String text;
  final Color color;
  final double value;

  final void Function(double)? onChangeEnd;
  final void Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.3,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<FontCubit, FontState>(
                    builder: (context, state) {
                      return Text(
                        'Текст',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: realFontSize(state.fontSize),
                            fontWeight: FontWeight
                                .values[fontWeightIndex(state.fontWeight)]),
                      );
                    },
                  ),
                ],
              ),
              SliderTheme(
                data: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Slider(
                    divisions: 7,
                    activeColor: color,
                    inactiveColor: Color(0xFFedecf1),
                    onChanged: onChanged,
                    onChangeEnd: onChangeEnd,
                    value: value,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
