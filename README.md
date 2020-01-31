A Dart interface for GoJS: https://gojs.net/

For a full working flowchart app, checkout for example/flowchart.

Simple example: 

```Dart
import 'package:gojs/gojs.dart';
import 'dart:html' as html;

// some simple html with a div like <div id="diagram"></div>

void main() {
  var diagram = html.document.getElementById('diagram');
  
  var myDiagram = GoJSDiagram(diagram)
    ..model = GoJSModel.fromJson('''
        [
          { "key": "Alpha" },
          { "key": "Beta" },
          { "key": "Gamma" }
        ]
    ''');
}
```