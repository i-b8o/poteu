import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/page_view/bloc.dart';
import '../../../../../bloc/save_paragraph/save_paragraph_cubit.dart';
import '../bottom_bar_black_icon.dart';

class clean extends StatelessWidget {
  const clean({
    Key? key,
    required this.fontHeight,
  }) : super(key: key);
  final double fontHeight;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await context.read<SaveParagraphCubit>().cleanEditedParagraphs();

          int orderNum = context.read<SaveParagraphCubit>().orderNum;

          context
              .read<PageViewBloc>()
              .add(PageViewParagraphSavedEvent(orderNum));
        },
        child: BottomBarBlackIcon(
            height: fontHeight, icon: Icons.cleaning_services));
  }
}
