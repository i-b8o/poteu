import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poteu/presentation/screens/navigation_drawer/cubit/expansion/expansion_cubit.dart';

class NavDrawerMenuItem extends StatelessWidget {
  const NavDrawerMenuItem({
    Key? key,
    this.children,
    required this.leadingIconData,
    required this.title,
    this.trailing,
    required this.index,
  }) : super(key: key);
  final List<Widget>? children;
  final IconData leadingIconData;
  final int index;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpansionCubit, int>(
      builder: (context, state) {
        return ExpansionTile(
          key: Key(index.toString()), //attention
          initiallyExpanded: index == state, //attention
          onExpansionChanged: (isOpen) {
            if (isOpen) {
              context.read<ExpansionCubit>().setSelected(index);
            }
          },
          trailing: trailing,
          backgroundColor: Theme.of(context).navigationRailTheme.indicatorColor,
          collapsedBackgroundColor:
              Theme.of(context).navigationRailTheme.backgroundColor,
          iconColor:
              Theme.of(context).navigationRailTheme.selectedIconTheme!.color,
          collapsedIconColor:
              Theme.of(context).navigationRailTheme.unselectedIconTheme!.color,
          textColor: Theme.of(context)
              .navigationRailTheme
              .selectedLabelTextStyle!
              .color,
          collapsedTextColor: Theme.of(context)
              .navigationRailTheme
              .unselectedLabelTextStyle!
              .color,
          title: Padding(
            padding: const EdgeInsets.only(bottom: .0),
            child: Text(
              title,
            ),
          ),
          leading: Icon(
            leadingIconData,
          ),
          children: children == null
              ? [Container()]
              : [
                  Container(
                      color:
                          Theme.of(context).navigationRailTheme.backgroundColor,
                      child: Column(children: children!))
                ],
        );
      },
    );
  }
}
