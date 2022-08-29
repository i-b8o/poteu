import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../notes_list/bloc/notes/notes_cubit.dart';

class NotesMenuItem extends StatelessWidget {
  const NotesMenuItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavDrawerMenuItem(
      onExpansionChanged: (bool val) async {
        await context.read<NotesCubit>().update(false);
        Navigator.of(context).pop();
        Navigator.pushNamed(
          context,
          '/notesList',
        );
      },
      trailing: const SizedBox(),
      leadingIconData: Icons.note_alt_outlined,
      title: 'Заметки',
    );
  }
}

class NavDrawerMenuItem extends StatelessWidget {
  const NavDrawerMenuItem({
    Key? key,
    this.children,
    required this.leadingIconData,
    required this.title,
    this.trailing,
    required this.onExpansionChanged,
  }) : super(key: key);
  final List<Widget>? children;
  final IconData leadingIconData;
  final void Function(bool)? onExpansionChanged;
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      onExpansionChanged: onExpansionChanged,
      trailing: trailing,
      backgroundColor: Theme.of(context).navigationRailTheme.indicatorColor,
      collapsedBackgroundColor:
          Theme.of(context).navigationRailTheme.backgroundColor,
      iconColor: Theme.of(context).navigationRailTheme.selectedIconTheme!.color,
      collapsedIconColor:
          Theme.of(context).navigationRailTheme.unselectedIconTheme!.color,
      textColor:
          Theme.of(context).navigationRailTheme.selectedLabelTextStyle!.color,
      collapsedTextColor:
          Theme.of(context).navigationRailTheme.unselectedLabelTextStyle!.color,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 3.0),
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
                  color: Theme.of(context).navigationRailTheme.backgroundColor,
                  child: Column(children: children!))
            ],
    );
  }
}
