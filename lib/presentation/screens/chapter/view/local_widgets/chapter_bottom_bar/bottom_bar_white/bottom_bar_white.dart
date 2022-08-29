import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../../bloc/colors/colors_cubit.dart';
import 'bottom_bar_white_colors_list_view.dart';
import 'bottom_bar_white_text.dart';
import 'color_picker/color_picker.dart';

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
          onPressed: () {
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

  void _pickColor(BuildContext context) => showDialog(
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
