@JS('go')
library gojs;

import 'dart:html';
import 'package:js/js.dart';

typedef LinkEventFn = Function(GoJSLinkEvent e);

@JS('AnimationManager')
class GoJSAnimationManager {
  @JS('None')
  external static GoJSAnimationManager get none;
  external set initialAnimationStyle(dynamic n);
}

@JS('TextBlock')
class GoJSTextBlock extends GoJSGraphObject {
  @JS('WrapFit')
  external static dynamic get wrapFit;

  external bool get editable;
  external GoJSSize get maxSize;
  external dynamic get wrap;
  external int get margin;
  external String get textAlign;
  external String get font;
  external String get stroke;
  external String get text;
  external set editable(bool n);
  external set maxSize(GoJSSize n);
  external set wrap(dynamic n);
  external set margin(int n);
  external set textAlign(String n);
  external set font(String n);
  external set stroke(String n);
  external set text(String n);
}

@JS('Tool')
class GoJSTool {}

@JS('ToolManager')
class GoJSToolManager extends GoJSTool {
  external GoJSLinkingTool get linkingTool;
  external GoJSRelinkingTool get relinkingTool;
}

@JS('LinkingBaseTool')
class GoJSLinkingBaseTool {}

@JS('LinkingTool')
class GoJSLinkingTool extends GoJSLinkingBaseTool {
  external GoJSLink get temporaryLink;
}

@JS('RelinkingTool')
class GoJSRelinkingTool extends GoJSLinkingBaseTool {
  external GoJSLink get temporaryLink;
}

@JS('Size')
class GoJSSize {
  external factory GoJSSize(dynamic x, dynamic y);
}

@JS('Geometry')
class GoJSGeometry {
  external void add(GoJSPathFigure fig);
  external set spot1(GoJSSpot n);
  external set spot2(GoJSSpot n);
}

@JS('PathFigure')
class GoJSPathFigure {
  external void add(GoJSPathSegment path);

  external factory GoJSPathFigure([double x, double y, bool filled]);
}

extension GoJSPathFigureAdvanced on GoJSPathFigure {
  void addAll(Iterable<GoJSPathSegment> paths) =>
      paths.forEach((path) => add(path));
}

@JS('PathSegment')
class GoJSPathSegment {
  @JS('Line')
  external static dynamic get line;
  external dynamic close();
  external factory GoJSPathSegment(dynamic type, double x, double y);
}

@JS('Shape')
class GoJSShape extends GoJSGraphObject {
  external static void defineFigureGenerator(
      String name, Function(GoJSShape shape, double w, double h) fn);
  external String get name;
  external set fill(String n);
  external String get figure;
  external set figure(String n);
  external String get portId;
  external set portId(String n);
  external String get cursor;
  external set cursor(String n);
  external String get stroke;
  external set stroke(String n);
  external double get strokeWidth;
  external set strokeWidth(double n);
  external String get toArrow;
  external set toArrow(String n);
  external dynamic get width;
  external set width(dynamic n);
  external dynamic get height;
  external set height(dynamic n);
  external dynamic get stretch;
  external set stretch(dynamic n);
  external GoJSSpot get alignment;
  external set alignment(GoJSSpot n);
  external GoJSSpot get fromSpot;
  external set fromSpot(GoJSSpot n);
  external GoJSSpot get toSpot;
  external set toSpot(GoJSSpot n);
  external bool get fromLinkable;
  external set fromLinkable(bool n);
  external bool get isPanelMain;
  external set isPanelMain(bool n);
  external bool get toLinkable;
  external set toLinkable(bool n);
  external GoJSSize get desiredSize;
  external set desiredSize(GoJSSize n);
  external Function([dynamic e, dynamic port, dynamic k]) get mouseEnter;
  external set mouseEnter(Function([dynamic e, dynamic port, dynamic k]));
  external Function([dynamic e, dynamic port, dynamic k]) get mouseLeave;
  external set mouseLeave(Function([dynamic e, dynamic port, dynamic k]));

  external factory GoJSShape();
}

@JS('Brush')
class GoJSBrush {}

@JS('Binding')
class GoJSBinding {
  external dynamic makeTwoWay([dynamic type]);
  external dynamic ofObject();

  external factory GoJSBinding(
      [String targetprop, String sourceprop, dynamic conv]);
}

@JS()
@anonymous
class GoJSLocation {
  external factory GoJSLocation({GoJSSpot locationSpot});
}

@JS('Point')
class GoJSPoint {
  external static dynamic get parse;
  external static dynamic get stringify;
}

@JS('Palette')
class GoJSPalette {
  external GoJSMap<String, GoJSPart> get nodeTemplateMap;
  external set nodeTemplateMap(GoJSMap<String, GoJSPart> n);
  external GoJSLinksModel get model;
  external set model(GoJSLinksModel n);
  external GoJSAnimationManager get animationManager;
  @JS('InitialAnimationStarting')
  external Function(GoJSDiagramEvent ev) get initialAnimationStarting;
  external set initialAnimationStarting(Function(GoJSDiagramEvent ev) n);

  external factory GoJSPalette([HtmlElement element]);
}

@JS('Map')
class GoJSMap<K, V> {
  external add(K k, V v);
}

@JS()
@anonymous
class GoJSDiagramEvent {
  external GoJSDiagram get diagram;
}

@JS('Animation')
class GoJSAnimation {
  @JS('EaseOutExpo')
  external static dynamic get easeOutExpo;
  external bool get isViewportUnconstrained;
  external set isViewportUnconstrained(bool n);
  external dynamic get easing;
  external set easing(dynamic n);
  external int get duration;
  external set duration(int n);

  external void add(GoJSDiagram diagram, String pos, dynamic a, dynamic b);
  external void start();
}

@JS('GraphLinksModel')
class GoJSLinksModel extends GoJSModel {
  external factory GoJSLinksModel([Iterable items, Iterable indexed]);
}

@JS('GraphObject')
class GoJSGraphObject {
  external bool get visible;
  external set visible(bool n);
  @JS('Horizontal')
  external static dynamic get horizontal;
  @JS('Vertical')
  external static dynamic get vertical;
  external void bind(GoJSBinding n);
  external set name(String n);
  external String get fill;
}

@JS('Panel')
class GoJSPanel extends GoJSGraphObject {
  @JS('Auto')
  external static dynamic get auto;
  @JS('Table')
  external static dynamic get table;
  external GoJSGraphObject findObject(String arg);
  external GoJSGraphObject get data;
  external void add(GoJSGraphObject element);
  external set type(dynamic n);
  external dynamic get type;
  external set segmentIndex(int n);
  external int get segmentIndex;
  external set segmentFraction(double n);
  external double get segmentFraction;
}

extension GoJSPanelAdvanced on GoJSPanel {
  void addAll(Iterable<GoJSGraphObject> els) {
    for (var el in els) add(el);
  }
}

@JS('Part')
class GoJSPart extends GoJSPanel {
  external set locationSpot(GoJSSpot n);
  external GoJSSpot get locationSpot;
}

@JS('Link')
class GoJSLink extends GoJSPart {
  @JS('Orthogonal')
  external static dynamic get orthogonal;
  @JS('AvoidsNodes')
  external static dynamic get avoidsNodes;
  @JS('JumpOver')
  external static dynamic get jumpOver;
  external GoJSNode get fromNode;

  external dynamic get routing;
  external set routing(dynamic n);
  external dynamic get curve;
  external set curve(dynamic n);
  external int get toShortLength;
  external set toShortLength(int n);
  external int get corner;
  external set corner(int n);
  external int get margin;
  external set margin(int n);
  external bool get relinkableFrom;
  external set relinkableFrom(bool n);
  external bool get relinkableTo;
  external set relinkableTo(bool n);
  external bool get reshapable;
  external set reshapable(bool n);
  external bool get resegmentable;
  external set resegmentable(bool n);
  external bool get selectionAdorned;
  external set selectionAdorned(bool n);
  external Function([dynamic ev, GoJSLink link, dynamic k]) get mouseEnter;
  external set mouseEnter(Function([dynamic ev, GoJSLink link, dynamic k]) n);
  external Function([dynamic ev, GoJSLink link, dynamic k]) get mouseLeave;
  external set mouseLeave(Function([dynamic ev, GoJSLink link, dynamic k]) n);
}

@JS('Node')
class GoJSNode extends GoJSPart {}

@JS()
class GoJSLinkEvent {}

@JS('Margin')
class GoJSMargin {
  external factory GoJSMargin(int x, int y, int w, int z);
}

@JS('Spot')
class GoJSSpot {
  @JS('BottomRight')
  external static GoJSSpot get bottomRight;
  @JS('TopLeft')
  external static GoJSSpot get topLeft;
  @JS('TopCenter')
  external static GoJSSpot get topCenter;
  @JS('Center')
  external static GoJSSpot get center;
  @JS('Top')
  external static GoJSSpot get top;
  @JS('Bottom')
  external static GoJSSpot get bottom;
  @JS('Right')
  external static GoJSSpot get right;
  @JS('Left')
  external static GoJSSpot get left;
  @JS('TopSide')
  external static GoJSSpot get topSide;
  @JS('LeftSide')
  external static GoJSSpot get leftSide;
  @JS('RightSide')
  external static GoJSSpot get rightSide;
  @JS('BottomSide')
  external static GoJSSpot get bottomSide;

  external bool equals(GoJSSpot);
  external int get x;
  external int get y;
  external int get offsetX;
  external int get offsetY;
  external bool get s;

  external factory GoJSSpot([double x, double y]);
}

// $(go.Brush, "Linear", { 0: "rgb(254, 201, 0)", 1: "rgb(254, 162, 0)" });
@JS()
@anonymous
class GoJSBrushOptions {
  external factory GoJSBrushOptions({@JS('0') String c0, @JS('1') String c1});
}

@JS('Diagram')
class GoJSDiagram {
  external GoJSModel get model;
  external set model(GoJSModel n);
  external GoJSToolManager get toolManager;
  external set toolManager(GoJSToolManager n);
  external GoJSMap<String, GoJSPart> get nodeTemplateMap;
  external GoJSLink get linkTemplate;
  external set linkTemplate(GoJSLink link);
  @JS('undoManager.isEnabled')
  external bool get undoManagerEnabled;
  @JS('undoManager.isEnabled')
  external set undoManagerEnabled(bool n);

  @JS('LinkDrawn')
  external set linkDrawn(LinkEventFn n);
  @JS('LinkDrawn')
  external LinkEventFn get linkDrawn;
  @JS('LinkRelinked')
  external set linkRelinked(LinkEventFn n);
  @JS('LinkRelinked')
  external LinkEventFn get linkRelinked;

  external factory GoJSDiagram(HtmlElement element);
}

@JS('Model')
class GoJSModel {
  external static GoJSModel fromJson(String buf);
  external List<GoJSNodeData> get nodeDataArray;
  external set nodeDataArray(List<GoJSNodeData> n);
}

@JS()
@anonymous
class GoJSNodeData {
  external String get key;

  external factory GoJSNodeData({String key});
}
