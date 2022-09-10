import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poteu/presentation/screens/chapter/bloc/page_view/bloc.dart';
import 'package:poteu/presentation/screens/chapter/bloc/save_paragraph/save_paragraph_cubit.dart';
import 'package:poteu/presentation/screens/chapter/view/local_widgets/chapter_bottom_bar/bottom_bar_black/bottom_bar_black_icon.dart';

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
