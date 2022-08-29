import 'package:flutter/material.dart';

class BottomBarBlackIcon extends StatelessWidget {
  const BottomBarBlackIcon({
    Key? key,
    required this.icon,
    required this.height,
  }) : super(key: key);

  final IconData icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 3,
      width: height * 3,
      child: Icon(
        icon,
        size: height,
        color: Theme.of(context).appBarTheme.toolbarTextStyle!.color,
      ),
    );
  }
}
