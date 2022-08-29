import 'package:flutter/material.dart';

class RegulationAppBar extends StatelessWidget {
  const RegulationAppBar({
    Key? key, required this.child, 
  }) : super(key: key);
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Theme.of(context).appBarTheme.elevation,
      child: child,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).appBarTheme.shadowColor!)),
      ),
    );
  }
}
