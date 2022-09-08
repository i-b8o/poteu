part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState(this.paragraphs);

  final List<EditableContentParagraph> paragraphs;

  @override
  List<Object> get props => [paragraphs];
}


