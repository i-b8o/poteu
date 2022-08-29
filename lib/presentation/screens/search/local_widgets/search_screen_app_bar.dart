import 'package:flutter/material.dart';

import '../../../widgets/regulation_app_bar.dart';

class SearchScreenAppBar extends StatelessWidget {
  const SearchScreenAppBar({
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
        mainAxisAlignment: MainAxisAlignment.start,
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
          Expanded(
            child: Row(mainAxisAlignment:MainAxisAlignment.center,
              children: [
                Text('Результаты поиска', style: Theme.of(context).appBarTheme.titleTextStyle),
              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width*0.1,)
        ],
      )),
    );
  }
}
