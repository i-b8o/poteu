import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poteu/presentation/screens/chapter/bloc/bottom_bar/bottom_bar_cubit.dart';

import 'package:poteu/presentation/screens/chapter/bloc/colors/colors_cubit.dart';
import 'package:poteu/presentation/screens/chapter/view/local_widgets/chapter_bottom_bar/bottom_bar_black/bottom_bar_black_icon.dart';

class close extends StatelessWidget {
  const close({
    Key? key,
    required this.fontHeight,
  }) : super(key: key);
  final double fontHeight;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          context.read<BottomBarCubit>().collapse();
          await context.read<ColorsCubit>().save(true);
        },
        child: BottomBarBlackIcon(
          height: fontHeight,
          icon: Icons.close,
        ));
  }
}
