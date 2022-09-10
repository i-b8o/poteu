import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poteu/presentation/screens/navigation_drawer/cubit/font/font_cubit.dart';
import 'package:poteu/presentation/screens/navigation_drawer/local_widgets/local_widgets/font_slider.dart';
import 'package:poteu/presentation/screens/navigation_drawer/local_widgets/local_widgets/menu_sub_Item.dart';
import 'package:poteu/presentation/screens/navigation_drawer/local_widgets/local_widgets/nav_drawer_menu_item.dart';

class FontMenuItem extends StatelessWidget {
  const FontMenuItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return NavDrawerMenuItem(
      leadingIconData: Icons.font_download_outlined,
      title: 'Шрифт',
      index: index,
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.5,
              child: SingleChildScrollView(
                child: BlocBuilder<FontCubit, FontState>(
                  builder: (context, state) {
                    return Column(children: [
                      MenuSubItem(
                        leading: 'Размер',
                        value: state.fontSize,
                        alertDialog: AlertDialog(
                            backgroundColor: Theme.of(context)
                                .navigationRailTheme
                                .backgroundColor,
                            content: BlocBuilder<FontCubit, FontState>(
                              builder: (context, state) {
                                return FontSlider(
                                  title: 'Размер',
                                  text: '${(state.fontSize * 100).round()}%',
                                  color: Color(0xFF5aa9f7),
                                  value: state.fontSize,
                                  onChanged: (double value) {
                                    context
                                        .read<FontCubit>()
                                        .setFontSize(value);
                                  },
                                  onChangeEnd: (value) => context
                                      .read<FontCubit>()
                                      .saveFontSize(value),
                                );
                              },
                            )),
                      ),
                      MenuSubItem(
                        leading: 'Насыщенность',
                        value: state.fontWeight,
                        alertDialog: AlertDialog(
                            backgroundColor: Theme.of(context)
                                .navigationRailTheme
                                .backgroundColor,
                            content: BlocBuilder<FontCubit, FontState>(
                              builder: (context, state) {
                                return FontSlider(
                                  title: 'Насыщенность',
                                  text: '${(state.fontWeight * 100).round()}%',
                                  color: Color(0xFF5aa9f7),
                                  value: state.fontWeight,
                                  onChanged: (double value) {
                                    context
                                        .read<FontCubit>()
                                        .setFontWeight(value);
                                  },
                                  onChangeEnd: (value) => context
                                      .read<FontCubit>()
                                      .saveFontWeight(value),
                                );
                              },
                            )),
                      ),
                      GestureDetector(
                        onTap: () => context.read<FontCubit>().resetFont(),
                        child: Container(
                          color: Theme.of(context)
                              .navigationRailTheme
                              .backgroundColor,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Сбросить настройки",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .navigationRailTheme
                                      .unselectedLabelTextStyle!
                                      .color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]);
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
