part of 'notes_cubit.dart';

abstract class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

class NotesInitial extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Color> colors;
  final List<EditedParagraphInfo> editedParagraphs;

  NotesLoaded({
    required this.colors,
    required this.editedParagraphs,
  });

  List<Object> get props => [colors, editedParagraphs];
}
