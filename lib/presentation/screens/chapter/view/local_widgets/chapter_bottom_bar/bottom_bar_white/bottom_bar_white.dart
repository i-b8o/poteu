import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:poteu/presentation/screens/chapter/bloc/colors/colors_cubit.dart';
import 'package:poteu/presentation/screens/chapter/view/local_widgets/chapter_bottom_bar/bottom_bar_white/bottom_bar_white_colors_list_view.dart';
import 'package:poteu/presentation/screens/chapter/view/local_widgets/chapter_bottom_bar/bottom_bar_white/bottom_bar_white_text.dart';
import 'package:poteu/presentation/screens/chapter/view/local_widgets/chapter_bottom_bar/bottom_bar_white/color_picker/color_picker.dart';

class BottomBarWhite extends StatelessWidget {
  const BottomBarWhite({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;
  // Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: Theme.of(context).textTheme.headline2!.backgroundColor),
        width: MediaQuery.of(context).size.width,
        height: height,
        child: Column(children: [
          SizedBox(
            height: height * 0.1,
          ),
          BottomBarWhiteText(height: height),
          SizedBox(
            height: height * 0.1,
          ),
          BottomBarWhiteColorsListView(
            height: height,
          ),
          SizedBox(
            height: height * 0.2,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              ColorsCircleBtn(height: height),
              RegulationsColorPicker(
                MediaQuery.of(context).size.width * 0.7,
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class ColorsCircleBtn extends StatelessWidget {
  const ColorsCircleBtn({Key? key, required this.height}) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height * 0.2,
        width: height * 0.2,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xFFf2f2f2))),
        child: IconButton(
          onPressed: () async {
            _pickColor(context);
          },
          icon: Container(
              child: Image.asset(
            'assets/images/colors.png',
            width: height * 0.1,
            height: height * 0.1,
          )),
        ));
  }

  Future<void> _pickColor(BuildContext context) async => showDialog(
      context: context,
      builder: (_) => AlertDialog(
              content: ColorPicker(
            pickerColor: Colors.blue,
            onColorChanged: (value) {
              context.read<ColorsCubit>().setColor(value.value);
            },
            portraitOnly: true,
          )));
}
