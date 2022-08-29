import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/colors/colors_cubit.dart';
import '../../../../../bloc/page_view/bloc.dart';
import '../../../../../bloc/save_paragraph/save_paragraph_cubit.dart';
import '../../../../../model/span.dart';
import '../bottom_bar_black_icon.dart';

class underlined extends StatelessWidget {
  const underlined({
    Key? key,
    required this.fontHeight,
  }) : super(key: key);
  final double fontHeight;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          int color = context.read<ColorsCubit>().getActiveColor();
          await context
              .read<SaveParagraphCubit>()
              .saveFormatedParagraph(Tag.u, color);

          int orderNum = context.read<SaveParagraphCubit>().orderNum;
          context
              .read<PageViewBloc>()
              .add(PageViewParagraphSavedEvent(orderNum));
        },
        child: BottomBarBlackIcon(
            height: fontHeight, icon: Icons.format_underline));
  }
}
