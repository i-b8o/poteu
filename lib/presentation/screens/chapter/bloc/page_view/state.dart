part of 'bloc.dart';

class PageViewInitState extends Equatable {
  const PageViewInitState({required this.changed});
  final bool changed;
  @override
  List<Object> get props => [changed];
}

class PageViewChapterLoadedState extends PageViewInitState {
  final TextEditingController appBarOrderNumController;
  final PageController pageController;
  final bool changed;
  final int chapterOrderNum, totalChapters;

  final String chapterName;

  final int paragraphOrderNum;
  final List<EditableParagraph> paragraphs;
  const PageViewChapterLoadedState(
      {required this.paragraphOrderNum,
      required this.appBarOrderNumController,
      required this.pageController,
      required this.chapterName,
      required this.changed,
      required this.paragraphs,
      required this.chapterOrderNum,
      required this.totalChapters})
      : super(changed: changed);
  @override
  List<Object> get props => [
        appBarOrderNumController,
        pageController,
        totalChapters,
        chapterName,
        paragraphOrderNum,
        paragraphs,
        changed
      ];
}
