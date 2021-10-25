import 'package:poteu/helper/data/table/table.dart';

class Paragraph {
  String chapter = "0";
  final List<String> text;
  final List<ParagraphTable> tables;

  Paragraph(this.text, this.tables);
}
