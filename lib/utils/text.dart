import 'package:html/parser.dart';

import '../presentation/screens/table_of_contents/model/edited_paragraph_info.dart';
import 'color.dart';

Map<int, String> getTags(String htmlString) {
  List<String> _symbols = htmlString.split('');
  Map<int, String> _tags = {};
  List<String> _tag = [];
  bool _tagOpened = false;
  int _tagOpenIndex = 0;
  // Count only pure text letters, do not count tags letters
  int _lettersIndex = 0;
  for (var i = 0; i < _symbols.length; i++) {
    String symbol = _symbols[i];

    // a html tag opened
    if (symbol == "<") {
      // Get the tag first symbol index
      _tagOpenIndex = _lettersIndex;
      _tagOpened = true;
    }

    // Pure text
    if (!_tagOpened) {
      // Count
      _lettersIndex++;
    }

    // Collect the tag symbols
    if (_tagOpened) {
      _tag.add(symbol);
    }

    // Tag closed
    if (symbol == ">") {
      _tags[_tagOpenIndex] = _tag.join("");
      _tagOpened = false;
      _tagOpenIndex = 0;
      _tag = [];
    }
  }
  return _tags;
}

Map<String, String> getLinks(String content) {
  Map<String, String> _result = {};
  final _document = parse(content);
  final _elements = _document.getElementsByTagName("a");
  if (!_elements.isEmpty) {
    _elements.forEach((element) {
      _result[element.text] = element.outerHtml;
    });
  }
  return _result;
}

Map<int, String> addTag(Map<int, String> tags, String tag, int start) {
  if (tags.containsKey(start)) {
    start++;
  }

  tags[start] = tag;
  return tags;
}

Map<int, String> clearTags(Map<int, String> tags) {
  Map<int, String> _newMap = {};
  tags.forEach((key, value) {
    if ((value.contains('<a')) || (value.contains('</a'))) {
      _newMap[key] = value;
    }
  });
  return _newMap;
}

String getStringForSave(Map<int, String> tags, String pureContent) {
  List<int> _sortedKeys = tags.keys.toList()..sort();
  if (_sortedKeys.length == 0) {
    return pureContent;
  }

  List<String> _symbols = pureContent.split('');
  List<String> _result = [];
  for (var i = 0; i < _symbols.length; i++) {
    if ((i == _sortedKeys[0]) && (tags[i] != null)) {
      // Add the tag and symbol to the result list
      _result.add(tags[i]!);
      
      _result.add(_symbols[i]);
      // Drop the tag from the tags map
      tags.removeWhere((key, value) => key == i);
      // Drop the key from the kyes list
      _sortedKeys.removeAt(0);

      if (_sortedKeys.length == 0) {
        // Add the rest of the pure content to the result list
        _result.add(pureContent.substring(i + 1));
        break;
      }
    } else {
      _result.add(_symbols[i]);
    }
  }
  if (_sortedKeys.length == 1) {
    _result.add(tags[_sortedKeys[0]] ?? "");
  }
  return _result.join('');
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  if (document.body == null) {
    return "";
  }
  if (parse(document.body!.text).documentElement == null) {
    return "";
  }
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

List<EditedParagraphLink> getEditedParagraphLinks(String content) {
  
  List<EditedParagraphLink> result = [];
  List<String> _colors = [];
  List<String> _text = [];
  var re = RegExp(r'(?<=-color:#).*?(?=;">)');
  var matches = re.allMatches(content);
  for (final RegExpMatch m in matches) {
    _colors.add(content.substring(m.start, m.end));
    
  }
  re = RegExp(r'(?<=;">).*?(?=</)');
  matches = re.allMatches(content);
  for (final RegExpMatch m in matches) {
    _text.add(parseHtmlString(content.substring(m.start, m.end)));
    
  }

  for (var i = 0; i < _colors.length; i++) {
    if (_text.length > i) {
      result.add(EditedParagraphLink(
          color: HexColor.fromHex(_colors[i]), text: _text[i]));
    }
  }

  return result;
}

List<String> getTextList(String content) {
  List<String> result = [];
  var re = RegExp(r'(?<=;">).*?(?=</)');
  var matches = re.allMatches(content);
  for (final RegExpMatch m in matches) {
    result.add(content.substring(m.start, m.end));
  }

  return result;
}
