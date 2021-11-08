import 'package:gojs/gojs.dart' as go;
import 'dart:html' as html;

// some simple html with a div like <div id="diagram"></div>

void main() {
  var diagram = html.document.getElementById('diagram');

  go.Diagram(diagram!)
    ..model = go.Model.fromJson('''
        [
          { "key": "Alpha" },
          { "key": "Beta" },
          { "key": "Gamma" }
        ]
    ''');
}
