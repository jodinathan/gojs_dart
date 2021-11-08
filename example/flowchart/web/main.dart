import 'package:gojs/gojs.dart' as go;
import 'package:js/js.dart';
import 'dart:html' as html;

void main() {
  var diagram = html.document.getElementById('diagram');
  var palette = html.document.getElementById('palette');

  try {
    var god = go.Diagram(diagram!)
      ..linkDrawn = allowInterop(showLinkLabel)
      ..linkRelinked = allowInterop(showLinkLabel);

    god.nodeTemplateMap.add(
        '', // the default category
        nodeStyle()
          ..type = go.Panel.table
          ..addAll([
            go.Panel()
              ..type = go.Panel.auto
              ..addAll([
                go.Shape()
                  ..figure = 'Rectangle'
                  ..fill = '#282c34'
                  ..stroke = '#00A9C9'
                  ..strokeWidth = 3.5
                  ..bind(go.Binding('figure', 'figure')),
                textStyle()
                  ..margin = 8
                  ..maxSize = go.Size(160, go.nan)
                  ..wrap = go.TextBlock.wrapFit
                  ..editable = true
                  ..bind(go.Binding('text').makeTwoWay())
              ]),
            makePort('T', go.Spot.top, go.Spot.topSide, false, true),
            makePort('L', go.Spot.left, go.Spot.leftSide, true, true),
            makePort('R', go.Spot.right, go.Spot.rightSide, true, true),
            makePort('B', go.Spot.bottom, go.Spot.bottomSide, true, false)
          ]));

    god.nodeTemplateMap.add(
        'Conditional',
        nodeStyle()
          ..type = go.Panel.table
          ..addAll([
            go.Panel()
              ..type = go.Panel.auto
              ..addAll([
                go.Shape()
                  ..figure = 'Diamond'
                  ..fill = '#282c34'
                  ..stroke = '#00A9C9'
                  ..strokeWidth = 3.5
                  ..bind(go.Binding('figure', 'figure')),
                textStyle()
                  ..margin = 8
                  ..maxSize = go.Size(160, go.nan)
                  ..wrap = go.TextBlock.wrapFit
                  ..editable = true
                  ..bind(go.Binding('text').makeTwoWay())
              ]),
            makePort('T', go.Spot.top, go.Spot.top, false, true),
            makePort('L', go.Spot.left, go.Spot.left, true, true),
            makePort('R', go.Spot.right, go.Spot.right, true, true),
            makePort('B', go.Spot.bottom, go.Spot.bottom, true, false)
          ]));

    god.nodeTemplateMap.add(
        'Start',
        nodeStyle()
          ..type = go.Panel.table
          ..addAll([
            go.Panel()
              ..type = go.Panel.auto
              ..addAll([
                go.Shape()
                  ..figure = 'Circle'
                  ..fill = '#282c34'
                  ..stroke = '#09d3ac'
                  ..strokeWidth = 3.5
                  ..desiredSize = go.Size(70, 70),
                textStyle('Start')..bind(go.Binding('text'))
              ]),
            makePort('L', go.Spot.left, go.Spot.left, true, false),
            makePort('R', go.Spot.right, go.Spot.right, true, false),
            makePort('B', go.Spot.bottom, go.Spot.bottom, true, false)
          ]));

    god.nodeTemplateMap.add(
        'End',
        nodeStyle()
          ..type = go.Panel.table
          ..addAll([
            (go.Panel()
              ..type = go.Panel.auto
              ..addAll([
                go.Shape()
                  ..figure = 'Circle'
                  ..fill = '#282c34'
                  ..stroke = '#DC3C00'
                  ..strokeWidth = 3.5
                  ..desiredSize = go.Size(70, 70),
                textStyle('End')..bind(go.Binding('text'))
              ])),
            makePort('T', go.Spot.top, go.Spot.top, false, true),
            makePort('L', go.Spot.left, go.Spot.left, false, true),
            makePort('R', go.Spot.right, go.Spot.right, false, true)
          ]));

    go.Shape.defineFigureGenerator('File', allowInterop((shape, w, h) {
      var geo = go.Geometry();
      var fig = go.PathFigure(0, 0, true); // starting point
      geo.add(fig);
      fig.addAll([
        go.PathSegment(go.PathSegment.line, .75 * w, 0),
        go.PathSegment(go.PathSegment.line, w, .25 * h),
        go.PathSegment(go.PathSegment.line, w, h),
        go.PathSegment(go.PathSegment.line, 0, h).close()
      ]);
      var fig2 = go.PathFigure(.75 * w, 0, false);
      geo.add(fig2);
      // The Fold
      fig2.addAll([
        go.PathSegment(go.PathSegment.line, .75 * w, .25 * h),
        go.PathSegment(go.PathSegment.line, w, .25 * h)
      ]);
      geo
        ..spot1 = go.Spot(0, .25)
        ..spot2 = go.Spot.bottomRight;
      return geo;
    }));

    god.nodeTemplateMap.add(
        'Comment',
        nodeStyle()
          ..type = go.Panel.auto
          ..addAll([
            go.Shape()
              ..figure = 'File'
              ..fill = '#282c34'
              ..stroke = '#DEE0A3'
              ..strokeWidth = 3,
            textStyle()
              ..margin = 8
              ..maxSize = go.Size(200, go.nan)
              ..wrap = go.TextBlock.wrapFit
              ..textAlign = 'center'
              ..editable = true
              ..bind(go.Binding('text').makeTwoWay())
          ]));

    god.linkTemplate = go.Link()
      ..routing = go.Link.avoidsNodes
      ..curve = go.Link.jumpOver
      ..corner = 5
      ..toShortLength = 4
      ..relinkableFrom = true
      ..relinkableTo = true
      ..reshapable = true
      ..resegmentable = true
      // mouse-overs subtly highlight links:
      ..mouseEnter = allowInterop(([e, link, k]) {
        (link.findObject('HIGHLIGHT') as go.Shape).stroke =
            'rgba(30,144,255,0.2)';
      })
      ..mouseLeave = allowInterop(([e, link, k]) {
        (link.findObject('HIGHLIGHT') as go.Shape).stroke = 'transparent';
      })
      ..selectionAdorned = false
      ..bind(go.Binding('points').makeTwoWay())
      ..addAll([
        go.Shape() // the highlight shape, normally transparent
          ..isPanelMain = true
          ..strokeWidth = 8
          ..stroke = 'transparent'
          ..name = 'HIGHLIGHT',
        go.Shape() // the link path shape
          ..isPanelMain = true
          ..strokeWidth = 2
          ..stroke = 'gray'
          ..bind(go.Binding('stroke', 'isSelected', allowInterop((sel, [k]) {
            return sel ? 'dodgerblue' : 'gray';
          })).ofObject()),
        go.Shape() // the arrowhead
          ..toArrow = 'standard'
          ..strokeWidth = 0
          ..fill = 'gray',
        go.Panel()
          ..type = go.Panel.auto
          ..visible = false
          ..name = 'LABEL'
          ..segmentIndex = 2
          ..segmentFraction = 0.5
          ..bind(go.Binding('visible', 'visible').makeTwoWay())
          ..addAll([
            go.Shape()
              ..figure = 'RoundedRectangle' // the label shape
              ..fill = '#F8F8F8'
              ..strokeWidth = 0,
            go.TextBlock()
              ..text = 'Yes'
              ..textAlign = 'center'
              ..font = '10pt helvetica, arial, sans-serif'
              ..stroke = '#333333'
              ..editable = true
              ..bind(go.Binding('text').makeTwoWay())
          ])
      ]);

    god.toolManager.linkingTool.temporaryLink.routing = go.Link.orthogonal;
    god.toolManager.relinkingTool.temporaryLink.routing = go.Link.orthogonal;

    // load
    var load = '''
      { "class": "go.GraphLinksModel",
        "linkFromPortIdProperty": "fromPort",
        "linkToPortIdProperty": "toPort",
        "nodeDataArray": [
      {"category":"Comment", "loc":"360 -10", "text":"Kookie Brittle", "key":-13},
      {"key":-1, "category":"Start", "loc":"175 0", "text":"Start"},
      {"key":0, "loc":"-5 75", "text":"Preheat oven to 375 F"},
      {"key":1, "loc":"175 100", "text":"In a bowl, blend: 1 cup margarine, 1.5 teaspoon vanilla, 1 teaspoon salt"},
      {"key":2, "loc":"175 200", "text":"Gradually beat in 1 cup sugar and 2 cups sifted flour"},
      {"key":3, "loc":"175 290", "text":"Mix in 6 oz (1 cup) Nestle's Semi-Sweet Chocolate Morsels"},
      {"key":4, "loc":"175 380", "text":"Press evenly into ungreased 15x10x1 pan"},
      {"key":5, "loc":"355 85", "text":"Finely chop 1/2 cup of your choice of nuts"},
      {"key":6, "loc":"175 450", "text":"Sprinkle nuts on top"},
      {"key":7, "loc":"175 515", "text":"Bake for 25 minutes and let cool"},
      {"key":8, "loc":"175 585", "text":"Cut into rectangular grid"},
      {"key":-2, "category":"End", "loc":"175 660", "text":"Enjoy!"}
      ],
        "linkDataArray": [
      {"from":1, "to":2, "fromPort":"B", "toPort":"T"},
      {"from":2, "to":3, "fromPort":"B", "toPort":"T"},
      {"from":3, "to":4, "fromPort":"B", "toPort":"T"},
      {"from":4, "to":6, "fromPort":"B", "toPort":"T"},
      {"from":6, "to":7, "fromPort":"B", "toPort":"T"},
      {"from":7, "to":8, "fromPort":"B", "toPort":"T"},
      {"from":8, "to":-2, "fromPort":"B", "toPort":"T"},
      {"from":-1, "to":0, "fromPort":"B", "toPort":"T"},
      {"from":-1, "to":1, "fromPort":"B", "toPort":"T"},
      {"from":-1, "to":5, "fromPort":"B", "toPort":"T"},
      {"from":5, "to":4, "fromPort":"B", "toPort":"T"},
      {"from":0, "to":4, "fromPort":"B", "toPort":"T"}
      ]}
      ''';

    god.model = go.Model.fromJson(load);

    var buf = '''
              { "class": "go.GraphLinksModel",
        "nodeDataArray": [{"category": "Start", "text": "Start"},
              {"text": "Step"},
              {"category": "Conditional", "text": "???"},
              {"category": "End", "text": "End"},
              {"category": "Comment", "text": "Comment"}]
              }
          ''';
    go.Palette(palette!)
      ..nodeTemplateMap = god.nodeTemplateMap
      //..model = go.LinksModel(lm)
      ..model = go.Model.fromJson(buf)
      ..initialAnimationStarting = allowInterop(animateFadeDown)
      ..animationManager.initialAnimationStyle = go.AnimationManager.none;
  } catch (e) {
    print('FlowChart example error: $e');
    html.window.console.error(e);
  } finally {
    print('Done! :D');
  }
}

void animateFadeDown(e) {
  var diagram = e.diagram;
  var animation = go.Animation();
  animation.isViewportUnconstrained =
      true; // So Diagram positioning rules let the animation start off-screen
  animation.easing = go.Animation.easeOutExpo;
  animation.duration = 900;
  // Fade "down", in other words, fade in from above
  animation.add(diagram, 'position', diagram.position.copy().offset(0, 200),
      diagram.position);
  animation.add(diagram, 'opacity', 0, 1);
  animation.start();
}

void showLinkLabel(e) {
  var label = e.subject.findObject('LABEL');

  if (label == null) {
    label.visible = (e.subject.fromNode.data.category == 'Conditional');
  }
}

go.Node nodeStyle() => go.Node()
  ..locationSpot = go.Spot.center
  ..bind(go.Binding('location', 'loc', go.Point.parse)
      .makeTwoWay(go.Point.stringify));

go.TextBlock textStyle([String? text]) => go.TextBlock()
  ..font = 'bold 11pt Lato, Helvetica, Arial, sans-serif'
  ..stroke = '#F8F8F8'
  ..text = text ?? go.undefined;

go.Shape makePort(
    String name, go.Spot align, go.Spot spot, dynamic output, dynamic input) {
  var horizontal = align.equals(go.Spot.top) || align.equals(go.Spot.bottom);
  // the port is basically just a transparent rectangle that stretches along the side of the node,
  // and becomes colored when the mouse passes over it
  return go.Shape()
    ..fill = 'transparent' // changed to a color in the mouseEnter event handler
    ..strokeWidth = 0 // no stroke
    ..width =
        horizontal ? go.nan : 8 // if not stretching horizontally, just 8 wide
    ..height =
        !horizontal ? go.nan : 8 // if not stretching vertically, just 8 tall
    ..alignment = align // align the port on the main Shape
    ..stretch =
        (horizontal ? go.GraphObject.horizontal : go.GraphObject.vertical)
    ..portId = name // declare this object to be a "port"
    ..fromSpot = spot // declare where links may connect at this port
    ..fromLinkable = output // declare whether the user may draw links from here
    ..toSpot = spot // declare where links may connect at this port
    ..toLinkable = input // declare whether the user may draw links to here
    ..cursor =
        'pointer' // show a different cursor to indicate potential link point
    ..mouseEnter = allowInterop(([e, port, k]) {
      // the PORT argument will be this Shape
      if (!e.diagram.isReadOnly) port.fill = 'rgba(255,0,255,0.5)';
    })
    ..mouseLeave = allowInterop(([e, port, k]) {
      port.fill = 'transparent';
    });
}
