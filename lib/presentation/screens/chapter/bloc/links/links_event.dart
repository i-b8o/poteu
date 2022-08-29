part of 'links_bloc.dart';

abstract class LinksEvent extends Equatable {
  const LinksEvent();

  @override
  List<Object> get props => [];
}

class EventLinkPressed extends LinksEvent {
  final int index;

  const EventLinkPressed(this.index);
  List<Object> get props => [index];
}
