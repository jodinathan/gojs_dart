import 'package:gojs/gojs.dart';
import 'dart:html' as html;

// some simple html with a div like <div id="diagram"></div>

void main() {
  var diagram = html.document.getElementById('diagram');
  
  GoJSDiagram(diagram)
    ..model = GoJSModel.fromJson('''
        [
          { "key": "Alpha" },
          { "key": "Beta" },
          { "key": "Gamma" }
        ]
    ''');
}