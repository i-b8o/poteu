import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poteu/presentation/screens/chapter/bloc/colors/colors_cubit.dart';

class BottomBarCircle extends StatelessWidget {
  const BottomBarCircle({
    Key? key,
    required this.height,
    required this.color,
    this.isActive = false,
    required this.index,
  }) : super(key: key);

  final double height;
  final Color color;
  final bool isActive;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ColorsCubit>().setActiveIndex(index);
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Text('Удалить цвет?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(_);
                          context.read<ColorsCubit>().deleteColor(index);
                        },
                        child: Text('Да')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(_);
                        },
                        child: Text('Нет'))
                  ],
                ));
      },
      child: Container(
        width: height * 0.15,
        height: height * 0.15,
        decoration: BoxDecoration(
            border: isActive ? Border.all(color: Colors.white) : null,
            shape: BoxShape.circle,
            color: color),
        child: isActive
            ? Icon(
                Icons.check,
                color: Colors.white,
              )
            : Container(),
      ),
    );
  }
}
