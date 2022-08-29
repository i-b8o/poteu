class Paragraph {
  final int id;
  final int num;
  final bool isHTML;
  final bool isTable;
  final bool isNFT;
  final String paragraphClass;
  final String content;
  final int chapterID;

  const Paragraph({
    required this.id,
    required this.num,
    required this.isHTML,
    required this.isTable,
    required this.isNFT,
    required this.paragraphClass,
    required this.content,
    required this.chapterID,
  });
}
