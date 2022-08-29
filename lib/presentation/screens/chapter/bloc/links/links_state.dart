part of 'links_bloc.dart';

abstract class LinksState extends Equatable {
  const LinksState();

  @override
  List<Object> get props => [];
}

class LinksInitialState extends LinksState {
  @override
  List<Object> get props => [];
}

class LinksLinkInState extends LinksState {
  final int index;

  const LinksLinkInState(this.index);
  @override
  List<Object> get props => [index];
}
