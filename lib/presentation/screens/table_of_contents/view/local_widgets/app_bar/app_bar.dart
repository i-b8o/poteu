import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poteu/presentation/screens/table_of_contents/bloc/table_of_contents/table_of_contents_bloc.dart';
import 'package:poteu/presentation/screens/table_of_contents/view/local_widgets/app_bar/init_app_bar.dart';

class TableOfContentsAppBar extends StatelessWidget {
  const TableOfContentsAppBar({
    Key? key,
  }) : super(key: key);

  Widget _buildChild(TableOfContentsState state) {
    if (state is TableOfContentsInitialState) {
      return InitAppBAr(
        name: state.name,
        title: state.title,
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableOfContentsBloc, TableOfContentsState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return _buildChild(state);
      },
    );
  }
}
