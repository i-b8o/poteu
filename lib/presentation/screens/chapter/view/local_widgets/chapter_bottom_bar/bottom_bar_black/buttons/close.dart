import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/bottom_bar/bottom_bar_cubit.dart';

import '../../../../../bloc/colors/colors_cubit.dart';
import '../bottom_bar_black_icon.dart';

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
