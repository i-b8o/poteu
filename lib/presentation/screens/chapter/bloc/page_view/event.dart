part of 'bloc.dart';

abstract class PageViewEvent extends Equatable {
  const PageViewEvent();

  @override
  List<Object> get props => [];
}

class PageViewInitialEvent extends PageViewEvent {}

class PageViewChapterChangedEvent extends PageViewEvent {
  final int chapterOrderNum;

  const PageViewChapterChangedEvent(this.chapterOrderNum);

  @override
  List<Object> get props => [chapterOrderNum];
}

class PageViewParagraphSavedEvent extends PageViewEvent {
  // Check if not neccessary
  final int paragraphOrderNum;
  const PageViewParagraphSavedEvent(this.paragraphOrderNum);

  @override
  List<Object> get props => [paragraphOrderNum];
}

class PageViewLoadParagraphsEvent extends PageViewEvent {
  final int paragraphOrderNum;
  const PageViewLoadParagraphsEvent(this.paragraphOrderNum);
  @override
  List<Object> get props => [paragraphOrderNum];
}

class PageViewChapterGoToEvent extends PageViewEvent {
  final int id;

  const PageViewChapterGoToEvent({required this.id});
  @override
  List<Object> get props => [id];
}
