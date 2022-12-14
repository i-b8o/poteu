import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poteu/bloc/speak/speak_cubit.dart';
import 'package:poteu/presentation/screens/chapter/bloc/colors/colors_cubit.dart';
import 'package:poteu/presentation/screens/chapter/view/local_widgets/chapter_app_bar/chapter_app_bar_pagination.dart';

class ChapterAppBar extends StatelessWidget {
  const ChapterAppBar({
    Key? key,
    required this.totalChapters,
    required this.controller,
    required this.pageController,
  }) : super(key: key);
  final int totalChapters;
  final TextEditingController controller;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () async {
            context.read<SpeakCubit>().stop();
            await context.read<ColorsCubit>().save(true);
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: Theme.of(context).appBarTheme.iconTheme!.size,
            color: Theme.of(context).appBarTheme.iconTheme!.color,
          ),
        ),
        ChapterAppBarPagination(
            controller: controller,
            pageController: pageController,
            totalChapters: totalChapters),
        IconButton(
          onPressed: () async {
            Navigator.pushNamed(
              context,
              '/searchScreen',
            );
          },
          icon: Icon(
            Icons.search,
            size: Theme.of(context).appBarTheme.iconTheme!.size,
            color: Theme.of(context).appBarTheme.iconTheme!.color,
          ),
        ),
      ],
    );
  }
}
