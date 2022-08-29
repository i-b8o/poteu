import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc/colors/colors_cubit.dart';
import 'bottom_bar_circle.dart';

class BottomBarWhiteColorsListView extends StatelessWidget {
  const BottomBarWhiteColorsListView({Key? key, required this.height})
      : super(key: key);
  final double height;

  BottomBarCircle _circlesBuilder(int colorInt, index, isActive) {
    return BottomBarCircle(
      height: height,
      color: Color(colorInt),
      index: index,
      isActive: isActive,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height * 0.15,
        child: BlocBuilder<ColorsCubit, ColorsState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            List<int> _colors = state.colorsList;
            int _activeIndex = state.activeIndex;
            return ListView.separated(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.07),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) =>
                  index != _colors.length
                      ? _circlesBuilder(
                          _colors[index],
                          index,
                          _activeIndex == index,
                        )
                      : GestureDetector(
                          onTap: () {
                            context.read<ColorsCubit>().addColor();
                          },
                          child: Container(
                              width: height * 0.15,
                              height: height * 0.15,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Color(0xFF8d8d8d)),
                                  shape: BoxShape.circle,
                                  color: Color(0xFFf9f9f9)),
                              child: Icon(
                                Icons.add,
                                color: Color(0xFF8d8d8d),
                              )),
                        ),
              itemCount: _colors.length + 1,
              separatorBuilder: (context, index) => SizedBox(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
            );
          },
        ));
  }
}
