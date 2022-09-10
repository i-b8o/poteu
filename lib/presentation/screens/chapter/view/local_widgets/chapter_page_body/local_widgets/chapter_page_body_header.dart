import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poteu/utils/font.dart';
import 'package:poteu/presentation/screens/navigation_drawer/cubit/font/font_cubit.dart';

class ChapterPageBodyHeader extends StatelessWidget {
  const ChapterPageBodyHeader({
    Key? key,
    required this.header,
    required this.pClass,
  }) : super(key: key);

  final String header, pClass;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pClass == "align_right"
          ? EdgeInsets.all(25.0)
          : EdgeInsets.only(top: 50.0, left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              child: Text(
            header,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).textTheme.headline1!.color,
                fontSize:
                    realFontSize(context.read<FontCubit>().state.fontSize) + 2),
          )),
        ],
      ),
    );
  }
}
