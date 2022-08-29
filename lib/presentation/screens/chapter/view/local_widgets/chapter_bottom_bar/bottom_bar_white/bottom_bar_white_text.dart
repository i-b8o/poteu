import 'package:flutter/material.dart';

class BottomBarWhiteText extends StatelessWidget {
  const BottomBarWhiteText({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.07,
        ),
        Text(
          'ЦВЕТА',
          style:
              TextStyle(fontSize: height * 0.05, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
