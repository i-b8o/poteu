import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../search/model/editable_content_paragraph.dart';
import '../../../bloc/table_of_contents/table_of_contents_bloc.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              context
                  .read<TableOfContentsBloc>()
                  .add(TableOfContentsInitialEvent());
            },
            icon: Icon(
              Icons.arrow_back,
              size: Theme.of(context).appBarTheme.iconTheme!.size,
              color: Theme.of(context).appBarTheme.iconTheme!.color,
            )),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextField(
              controller: context.read<TableOfContentsBloc>().searchController,
              cursorColor: Theme.of(context).appBarTheme.foregroundColor,
              style: Theme.of(context).appBarTheme.toolbarTextStyle,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                prefixIconConstraints:
                    BoxConstraints(minWidth: 22, maxHeight: 22),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(
                    Icons.search,
                    color: Theme.of(context).appBarTheme.foregroundColor,
                  ),
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).iconTheme.color!)),
                isDense: true,
                hintText: 'Поиск',
              ),
              // style: TextStyle(
              //   fontSize: 15.0,
              // ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            List<EditableContentParagraph> _paragraphs =
                context.read<TableOfContentsBloc>().search();
            Navigator.pushNamed(context, '/searchScreen',
                arguments: _paragraphs);
          },
          icon: Icon(
            Icons.search,
            size: Theme.of(context).appBarTheme.iconTheme!.size,
            color: Theme.of(context).appBarTheme.iconTheme!.color,
          ),
        ),
      ],
    );
  }
}
