part of 'table_of_contents_bloc.dart';

abstract class TableOfContentsEvent extends Equatable {
  const TableOfContentsEvent();

  @override
  List<Object> get props => [];
}

class TableOfContentsInitialEvent extends TableOfContentsEvent {
  const TableOfContentsInitialEvent();
}

// class TableOfContentsSearchTextFieldActivatedEvent
//     extends TableOfContentsEvent {
//   const TableOfContentsSearchTextFieldActivatedEvent();
// }
