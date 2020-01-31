import 'package:gojs/gojs.dart';
import 'package:js/js.dart';
import 'dart:html' as html;

void main() {
  var diagram = html.document.getElementById('diagram');
  var palette = html.document.getElementById('palette');

  try {
    var god = GoJSDiagram(diagram)
      ..linkDrawn = allowInterop(showLinkLabel)
      ..linkRelinked = allowInterop(showLinkLabel);

    god.nodeTemplateMap.add(
        '', // the default category
        nodeStyle()
          ..type = GoJSPanel.table
          ..addAll([
            GoJSPanel()
              ..type = GoJSPanel.auto
              ..addAll([
                GoJSShape()
                  ..figure = 'Rectangle'
                  ..fill = '#282c34'
                  ..stroke = '#00A9C9'
                  ..strokeWidth = 3.5
                  ..bind(GoJSBinding('figure', 'figure')),
                textStyle()
                  ..margin = 8
                  ..maxSize = GoJSSize(160, nan)
                  ..wrap = GoJSTextBlock.wrapFit
                  ..editable = true
                  ..bind(GoJSBinding('text').makeTwoWay())
              ]),
            makePort('T', GoJSSpot.top, GoJSSpot.topSide, false, true),
            makePort('L', GoJSSpot.left, GoJSSpot.leftSide, true, true),
            makePort('R', GoJSSpot.right, GoJSSpot.rightSide, true, true),
            makePort('B', GoJSSpot.bottom, GoJSSpot.bottomSide, true, false)
          ]));

    god.nodeTemplateMap.add(
        'Conditional',
        nodeStyle()
          ..type = GoJSPanel.table
          ..addAll([
            GoJSPanel()
              ..type = GoJSPanel.auto
              ..addAll([
                GoJSShape()
                  ..figure = 'Diamond'
                  ..fill = '#282c34'
                  ..stroke = '#00A9C9'
                  ..strokeWidth = 3.5
                  ..bind(GoJSBinding('figure', 'figure')),
                textStyle()
                  ..margin = 8
                  ..maxSize = GoJSSize(160, nan)
                  ..wrap = GoJSTextBlock.wrapFit
                  ..editable = true
                  ..bind(GoJSBinding('text').makeTwoWay())
              ]),
            makePort('T', GoJSSpot.top, GoJSSpot.top, false, true),
            makePort('L', GoJSSpot.left, GoJSSpot.left, true, true),
            makePort('R', GoJSSpot.right, GoJSSpot.right, true, true),
            makePort('B', GoJSSpot.bottom, GoJSSpot.bottom, true, false)
          ]));

    god.nodeTemplateMap.add(
        'Start',
        nodeStyle()
          ..type = GoJSPanel.table
          ..addAll([
            GoJSPanel()
              ..type = GoJSPanel.auto
              ..addAll([
                GoJSShape()
                  ..figure = 'Circle'
                  ..fill = '#282c34'
                  ..stroke = '#09d3ac'
                  ..strokeWidth = 3.5
                  ..desiredSize = GoJSSize(70, 70),
                textStyle('Start')..bind(GoJSBinding('text'))
              ]),
            makePort('L', GoJSSpot.left, GoJSSpot.left, true, false),
            makePort('R', GoJSSpot.right, GoJSSpot.right, true, false),
            makePort('B', GoJSSpot.bottom, GoJSSpot.bottom, true, false)
          ]));

    god.nodeTemplateMap.add(
        'End',
        nodeStyle()
          ..type = GoJSPanel.table
          ..addAll([
            (GoJSPanel()
              ..type = GoJSPanel.auto
              ..addAll([
                GoJSShape()
                  ..figure = 'Circle'
                  ..fill = '#282c34'
                  ..stroke = '#DC3C00'
                  ..strokeWidth = 3.5
                  ..desiredSize = GoJSSize(70, 70),
                textStyle('End')..bind(GoJSBinding('text'))
              ])),
            makePort('T', GoJSSpot.top, GoJSSpot.top, false, true),
            makePort('L', GoJSSpot.left, GoJSSpot.left, false, true),
            makePort('R', GoJSSpot.right, GoJSSpot.right, false, true)
          ]));

    GoJSShape.defineFigureGenerator('File', allowInterop((shape, w, h) {
      var geo = GoJSGeometry();
      var fig = GoJSPathFigure(0, 0, true); // starting point
      geo.add(fig);
      fig.addAll([
        GoJSPathSegment(GoJSPathSegment.line, .75 * w, 0),
        GoJSPathSegment(GoJSPathSegment.line, w, .25 * h),
        GoJSPathSegment(GoJSPathSegment.line, w, h),
        GoJSPathSegment(GoJSPathSegment.line, 0, h).close()
      ]);
      var fig2 = GoJSPathFigure(.75 * w, 0, false);
      geo.add(fig2);
      // The Fold
      fig2.addAll([
        GoJSPathSegment(GoJSPathSegment.line, .75 * w, .25 * h),
        GoJSPathSegment(GoJSPathSegment.line, w, .25 * h)
      ]);
      geo
        ..spot1 = GoJSSpot(0, .25)
        ..spot2 = GoJSSpot.bottomRight;
      return geo;
    }));

    god.nodeTemplateMap.add(
        'Comment',
        nodeStyle()
          ..type = GoJSPanel.auto
          ..addAll([
            GoJSShape()
              ..figure = 'File'
              ..fill = '#282c34'
              ..stroke = '#DEE0A3'
              ..strokeWidth = 3,
            textStyle()
              ..margin = 8
              ..maxSize = GoJSSize(200, nan)
              ..wrap = GoJSTextBlock.wrapFit
              ..textAlign = 'center'
              ..editable = true
              ..bind(GoJSBinding('text').makeTwoWay())
          ]));

    god.linkTemplate = GoJSLink()
      ..routing = GoJSLink.avoidsNodes
      ..curve = GoJSLink.jumpOver
      ..corner = 5
      ..toShortLength = 4
      ..relinkableFrom = true
      ..relinkableTo = true
      ..reshapable = true
      ..resegmentable = true
      // mouse-overs subtly highlight links:
      ..mouseEnter = allowInterop(([e, link, k]) {
        (link.findObject('HIGHLIGHT') as GoJSShape).stroke =
            'rgba(30,144,255,0.2)';
      })
      ..mouseLeave = allowInterop(([e, link, k]) {
        (link.findObject('HIGHLIGHT') as GoJSShape).stroke = 'transparent';
      })
      ..selectionAdorned = false
      ..bind(GoJSBinding('points').makeTwoWay())
      ..addAll([
        GoJSShape() // the highlight shape, normally transparent
          ..isPanelMain = true
          ..strokeWidth = 8
          ..stroke = 'transparent'
          ..name = 'HIGHLIGHT',
        GoJSShape() // the link path shape
          ..isPanelMain = true
          ..strokeWidth = 2
          ..stroke = 'gray'
          ..bind(GoJSBinding('stroke', 'isSelected', allowInterop((sel) {
            return sel ? 'dodgerblue' : 'gray';
          })).ofObject()),
        GoJSShape() // the arrowhead
          ..toArrow = 'standard'
          ..strokeWidth = 0
          ..fill = 'gray',
        GoJSPanel()
          ..type = GoJSPanel.auto
          ..visible = false
          ..name = 'LABEL'
          ..segmentIndex = 2
          ..segmentFraction = 0.5
          ..bind(GoJSBinding('visible', 'visible').makeTwoWay())
          ..addAll([
            GoJSShape()
              ..figure = 'RoundedRectangle' // the label shape
              ..fill = '#F8F8F8'
              ..strokeWidth = 0,
            GoJSTextBlock()
              ..text = 'Yes'
              ..textAlign = 'center'
              ..font = '10pt helvetica, arial, sans-serif'
              ..stroke = '#333333'
              ..editable = true
              ..bind(GoJSBinding('text').makeTwoWay())
          ])
      ]);

    god.toolManager.linkingTool.temporaryLink.routing = GoJSLink.orthogonal;
    god.toolManager.relinkingTool.temporaryLink.routing = GoJSLink.orthogonal;

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

    god.model = GoJSModel.fromJson(load);

    var buf = '''
              { "class": "go.GraphLinksModel",
        "nodeDataArray": [{"category": "Start", "text": "Start"},
              {"text": "Step"},
              {"category": "Conditional", "text": "???"},
              {"category": "End", "text": "End"},
              {"category": "Comment", "text": "Comment"}]
              }
          ''';
    GoJSPalette(palette)
      ..nodeTemplateMap = god.nodeTemplateMap
      //..model = GoJSLinksModel(lm)
      ..model = GoJSModel.fromJson(buf)
      ..initialAnimationStarting = allowInterop(animateFadeDown)
      ..animationManager.initialAnimationStyle = GoJSAnimationManager.none;
  } catch (e) {
    print('FlowChart example error: $e');
    html.window.console.error(e);
  } finally {
    print('Done! :D');
  }
}

void animateFadeDown(e) {
  var diagram = e.diagram;
  var animation = GoJSAnimation();
  animation.isViewportUnconstrained =
      true; // So Diagram positioning rules let the animation start off-screen
  animation.easing = GoJSAnimation.easeOutExpo;
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

GoJSNode nodeStyle() => GoJSNode()
  ..locationSpot = GoJSSpot.center
  ..bind(GoJSBinding('location', 'loc', GoJSPoint.parse)
      .makeTwoWay(GoJSPoint.stringify));

GoJSTextBlock textStyle([String text]) => GoJSTextBlock()
  ..font = 'bold 11pt Lato, Helvetica, Arial, sans-serif'
  ..stroke = '#F8F8F8'
  ..text = text ?? undefined;

GoJSShape makePort(
    String name, GoJSSpot align, GoJSSpot spot, dynamic output, dynamic input) {
  var horizontal = align.equals(GoJSSpot.top) || align.equals(GoJSSpot.bottom);
  // the port is basically just a transparent rectangle that stretches along the side of the node,
  // and becomes colored when the mouse passes over it
  return GoJSShape()
    ..fill = 'transparent' // changed to a color in the mouseEnter event handler
    ..strokeWidth = 0 // no stroke
    ..width =
        horizontal ? nan : 8 // if not stretching horizontally, just 8 wide
    ..height =
        !horizontal ? nan : 8 // if not stretching vertically, just 8 tall
    ..alignment = align // align the port on the main Shape
    ..stretch =
        (horizontal ? GoJSGraphObject.horizontal : GoJSGraphObject.vertical)
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
