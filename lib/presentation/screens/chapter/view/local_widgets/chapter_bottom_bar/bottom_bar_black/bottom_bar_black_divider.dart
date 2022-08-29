import 'package:flutter/material.dart';

class BottomBarBlackDivider extends StatelessWidget {
  const BottomBarBlackDivider({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: Theme.of(context).dividerTheme.color,
      indent: height / 4,
      endIndent: height / 4,
      thickness: 2,
    );
  }
}
