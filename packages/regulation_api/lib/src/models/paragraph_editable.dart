class EditableParagraph {
  final int id;
  final int num;
  final List<String> textToSpeech;
  final bool isTable;
  final bool isNFT;
  final String editableParagraphClass;
  int edited;
  String content;
  final int chapterID;

  EditableParagraph( {
    required this.id,
    required this.num,
    required this.textToSpeech,
    required this.isTable,
    required this.isNFT,
    required this.editableParagraphClass,
    required this.content,
    required this.chapterID,
    required this.edited,
  });
}
