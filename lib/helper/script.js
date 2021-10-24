var header = "";
var num = "";
var paragraphs = [];
var texts = [];

const myMap = new Map();
myMap.set('I', 1);
myMap.set('V', 5);
myMap.set('X', 10);
myMap.set('L', 50);
myMap.set('C', 100);
myMap.set('D', 500);
myMap.set('M', 1000);

var romanToInt = function(s) {
    var result = 0;
    if (s) {
        var s1 = s.split('');
        s1.forEach(function(e, i) {
            result += myMap.get(e) < myMap.get(s1[i + 1]) ? -myMap.get(e) : myMap.get(e);
        });
    }
    return result;
}
var text = document.getElementsByClassName("text")[0];
header = text.getElementsByTagName("h1")[0].innerText.replace(/^\s+|\s+$/g, '').replace(/\n/g, ' ');
num = romanToInt(header.split(".")[0]);
var paragraphsAtFirst = text.getElementsByClassName("U");

Array.prototype.slice.apply(paragraphsAtFirst).forEach(function(p) {
    if (p.innerText.length < 5) { return };
    if (p.innerText.match(/^\d/)) {
        texts[texts.length - 1] = texts[texts.length - 1] + "],[])";
        paragraphs.push(texts);
        texts = [];
        texts.push("Paragraph(['" + p.innerText + "'");
    } else {
        texts.push("'" + p.innerText + "'");
    }
});
texts[texts.length - 1] = texts[texts.length - 1] + "],[])";
paragraphs.push(texts);
"Chapter('" + num.toString() + "','" + header + "', [" + paragraphs + "],),";