import 'package:poteu/helper/data/paragraph/paragraph.dart';

class Chapter {
  final String name;
  final String num;
  final List<Paragraph> paragraphs;

  Chapter(this.num, this.name, this.paragraphs);
}
