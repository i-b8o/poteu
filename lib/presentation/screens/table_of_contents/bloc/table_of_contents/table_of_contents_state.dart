part of 'table_of_contents_bloc.dart';

abstract class TableOfContentsState extends Equatable {
  const TableOfContentsState();

  @override
  List<Object> get props => [];
}

class TableOfContentsInitialState extends TableOfContentsState {
  final String title;
  final String name;

  const TableOfContentsInitialState({required this.title, required this.name});
}

// class TableOfContentsSearchTextFieldActivatedState
//     extends TableOfContentsState {}
