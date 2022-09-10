import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poteu/presentation/widgets/regulation_app_bar.dart';
import 'package:poteu/presentation/screens/search/bloc/search/search_cubit.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        right: MediaQuery.of(context).size.width * 0.1,
      ),
      child: RegulationAppBar(
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
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
                  autofocus: true,
                  controller: context.read<SearchCubit>().searchController,
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
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color!)),
                    isDense: true,
                    hintText: 'Поиск',
                  ),
                  onChanged: (content) {
                    context.read<SearchCubit>().search();
                  },
                ),
              ),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.search,
            //     size: Theme.of(context).appBarTheme.iconTheme!.size,
            //     color: Theme.of(context).appBarTheme.iconTheme!.color,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
