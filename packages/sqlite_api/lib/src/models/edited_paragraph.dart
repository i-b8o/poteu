const String tableNotes = 'paragraphs';

class EditedParagraphFields {
  static final List<String> values = [text];

  static const String id = '_id';
  static const String paragraphId = '_paragraphId';
  static const String chapterId = '_chapterId';
  static const String edited = 'edited';
  static const String text = 'text';
  static const String lastTouched = 'lastTouched';
}

class EditedParagraph {
  final int? id;
  final int paragraphId;
  final int chapterId;
  final int lastTouched;
  final int edited;
  final String text;

  EditedParagraph({
    this.id,
    required this.paragraphId,
    required this.chapterId,
    required this.lastTouched,
    required this.edited,
    required this.text,
  });

  Map<String, Object?> toJson() => {
        EditedParagraphFields.id: id,
        EditedParagraphFields.paragraphId: paragraphId,
        EditedParagraphFields.chapterId: chapterId,
        EditedParagraphFields.lastTouched: lastTouched,
        EditedParagraphFields.edited: edited,
        EditedParagraphFields.text: text,
      };

  static EditedParagraph fromJson(Map<String, Object?> json) => EditedParagraph(
        id: json[EditedParagraphFields.id] as int,
        paragraphId: json[EditedParagraphFields.paragraphId] as int,
        chapterId: json[EditedParagraphFields.chapterId] as int,
        lastTouched: json[EditedParagraphFields.lastTouched] as int,
        edited: json[EditedParagraphFields.edited] as int,
        text: json[EditedParagraphFields.text] as String,
      );

  EditedParagraph copyWith({
    int? id,
    int? paragraphId,
    int? chapterId,
    int? lastTouched,
    int? edited,
    String? text,
  }) {
    return EditedParagraph(
      id: id ?? this.id,
      paragraphId: paragraphId ?? this.paragraphId,
      chapterId: chapterId ?? this.chapterId,
      edited: edited ?? this.edited,
      text: text ?? this.text,
      lastTouched: lastTouched ?? this.lastTouched,
    );
  }
}
