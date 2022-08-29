part of 'save_paragraph_cubit.dart';

abstract class SaveParagraphState extends Equatable {
  const SaveParagraphState();

  @override
  List<Object> get props => [];
}

class SaveParagraphInitial extends SaveParagraphState {}

class SaveParagraphEmptySelected extends SaveParagraphState {
  final Tag tag;

  SaveParagraphEmptySelected(this.tag);
  @override
  List<Object> get props => [tag];
}
