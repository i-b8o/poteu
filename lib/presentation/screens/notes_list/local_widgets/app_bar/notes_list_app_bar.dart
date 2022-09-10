import 'package:flutter/material.dart';
import 'package:poteu/presentation/widgets/regulation_app_bar.dart';
import 'package:poteu/presentation/screens/notes_list/local_widgets/app_bar/notes_list_bottm_sheet.dart';

class NotesListAppBar extends StatelessWidget {
  const NotesListAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: RegulationAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              size: Theme.of(context).appBarTheme.iconTheme!.size,
              color: Theme.of(context).appBarTheme.iconTheme!.color,
            ),
          ),
          Text('Заметки', style: Theme.of(context).appBarTheme.titleTextStyle),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return NotesListAppBarBottomSheet();
                  });
            },
            icon: Icon(
              Icons.sort,
              size: Theme.of(context).appBarTheme.iconTheme!.size,
              color: Theme.of(context).appBarTheme.iconTheme!.color,
            ),
          ),
        ],
      )),
    );
  }
}
