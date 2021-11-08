@JS('go')
library gojs;

import 'dart:math' as math;
import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:js/js.dart';
import 'window.dart';

typedef LinkEventFn = Function(LinkEvent e);

void _jsFn(Function fn) {
  try {
    fn();
  } catch (e, st) {
    print('JsError!');
    window.console.error(e);
    window.console.error(st);
  }
}

/// https://gojs.net/latest/api/symbols/AnimationManager.html
@JS()
class AnimationManager {
  @JS('None')
  external static AnimationManager get none;
  @JS('AnimateLocations')
  external static AnimationManager get animateLocations;
  external set initialAnimationStyle(dynamic n);
  external set isInitial(bool n);
  external bool get isInitial;

  external factory AnimationManager();
}

/// https://gojs.net/latest/api/symbols/TextBlock.html
@JS()
class TextBlock extends GraphObject {
  @JS('WrapFit')
  external static dynamic get wrapFit;
  @JS('OverflowEllipsis')
  external static dynamic get overflowEllipsis;

  external bool get editable;
  external Size get maxSize;
  external dynamic get wrap;
  external String get textAlign;
  external String get font;
  external String get text;
  external set editable(bool n);
  external set maxSize(Size n);
  external set wrap(dynamic n);
  external set textAlign(String n);
  external set font(String n);
  external set text(String n);
  external dynamic get overflow;
  external set overflow(dynamic n);
  external int get maxLines;
  external set maxLines(int n);

  external factory TextBlock();
}

/// https://gojs.net/latest/api/symbols/Tool.html
@JS()
class Tool {
  external factory Tool();
}

/// https://gojs.net/latest/api/symbols/ToolManager.html
@JS()
class ToolManager extends Tool {
  external LinkingTool get linkingTool;
  external RelinkingTool get relinkingTool;
  external DraggingTool get draggingTool;
  external set draggingTool(DraggingTool dtool);

  external factory ToolManager();
}

/// https://gojs.net/latest/api/symbols/LinkingBaseTool.html
@JS()
class LinkingBaseTool {
  external LinkValidationFn get linkValidation;
  external set linkValidation(LinkValidationFn n);

  external factory LinkingBaseTool();
}

/// https://gojs.net/latest/api/symbols/LinkingTool.html
@JS()
class LinkingTool extends LinkingBaseTool {
  external Link get temporaryLink;

  external factory LinkingTool();
}

/// https://gojs.net/latest/api/symbols/RelinkingTool.html
@JS()
class RelinkingTool extends LinkingBaseTool {
  external Link get temporaryLink;

  external factory RelinkingTool();
}

/// https://gojs.net/latest/api/symbols/Size.html
@JS()
class Size {
  external num get width;
  external num get height;
  external factory Size(dynamic x, dynamic y);
}

/// https://gojs.net/latest/api/symbols/Geometry.html
@JS()
class Geometry {
  external void add(PathFigure fig);
  external set spot1(Spot n);
  external set spot2(Spot n);
  external static Geometry parse(String buf, bool ok);
  external void setSpots([double x, double y, double w, double z]);

  external factory Geometry();
}

/// https://gojs.net/latest/api/symbols/PathFigure.html
@JS()
class PathFigure {
  external void add(PathSegment path);

  external factory PathFigure([double x, double y, bool filled]);
}

extension PathFigureAdvanced on PathFigure {
  void addAll(Iterable<PathSegment> paths) =>
      paths.forEach((path) => add(path));
}

/// https://gojs.net/latest/api/symbols/PathSegment.html
@JS()
class PathSegment {
  @JS('Line')
  external static dynamic get line;
  @JS('Bezier')
  external static dynamic get bezier;
  external PathSegment close();
  external factory PathSegment(dynamic type, double x, double y,
      [num x1, num y1, num x2, dynamic y2, bool clockwise]);
}

/// https://gojs.net/latest/api/symbols/Shape.html
@JS()
class Shape extends GraphObject {
  external static void defineFigureGenerator(
      String name, Function(Shape shape, double w, double h) fn);
  external String get name;
  external String get figure;
  external set figure(String n);

  external String get stroke;
  external set stroke(String n);
  external double get strokeWidth;
  external set strokeWidth(double n);
  external List<num> get strokeDashArray;
  external set strokeDashArray(List<num> n);
  external num get strokeDashOffset;
  external set strokeDashOffset(num n);
  external String get toArrow;
  external set toArrow(String n);
  external String get fromArrow;
  external set fromArrow(String n);
  external double get scale;
  external set scale(double n);
  external dynamic get parameter1;
  external set parameter1(dynamic n);
  external int get angle;
  external set angle(int n);
  external int get interval;
  external set interval(int n);
  external Geometry get geometry;
  external set geometry(Geometry n);

  external bool get isPanelMain;
  external set isPanelMain(bool n);

  external factory Shape();
}

extension ShapeAdvanced on Shape {
  void strokeless() => strokeWidth = 0;
}

/// https://gojs.net/latest/api/symbols/Brush.html
@JS()
class Brush {
  @JS('Linear')
  external static dynamic get linear;
  external void addColorStop(double x, String color);
  external Spot get start;
  external set start(Spot n);
  external Spot get stop;
  external set stop(Spot n);

  external factory Brush([dynamic type]);
}

extension BrushAdvanced on Brush {
  void addColors(Iterable<dynamic> items) =>
      items.forEach((item) => addColorStop(item[0], item[1]));
}

/// https://gojs.net/latest/api/symbols/Binding.html
@JS()
class Binding {
  external Binding makeTwoWay([dynamic type]);
  external Binding ofObject();

  external factory Binding(
      [String targetprop,
      String sourceprop,
      String Function(dynamic arg, [dynamic arg2]) conv]);
}

/// https://gojs.net/latest/api/symbols/Point.html
@JS()
class Point {
  external static String Function(dynamic arg, [dynamic arg2]) get parse;
  external static String Function(dynamic arg, [dynamic arg2]) get stringify;
  external num get x;
  external num get y;
  external Point copy();
  external Point add(Point n);
  external Point offset(double x, double y);

  external factory Point([num x, num y]);
}

extension PointMath on math.Point {
  Point to() => Point(this.x, this.y);
}

@JS()
class Placeholder extends GraphObject {
  external factory Placeholder();
}

/// https://gojs.net/latest/api/symbols/Palette.html
@JS()
class Palette extends Diagram {
  external factory Palette([Element element]);
}

/// https://gojs.net/latest/api/symbols/Map.html
@JS('Map')
class GoMap<K, V> {
  external add(K k, V v);
  external Iterator<V> get iteratorValues;
  external factory GoMap();
}

/// https://gojs.net/latest/api/symbols/Set.html
@JS('Set')
class GoSet<T> {
  external T first();
  external bool contains(T item);
  external factory GoSet();
}

@JS()
@anonymous
class DiagramEvent {
  external Diagram get diagram;
  external dynamic get subject;
  external dynamic get parameter;
}

/// https://gojs.net/latest/api/symbols/Animation.html
@JS()
class Animation {
  @JS('EaseOutExpo')
  external static dynamic get easeOutExpo;
  @JS('EaseLinear')
  external static dynamic get easeLinear;
  @JS('EaseInExpo')
  external static dynamic get easeInExpo;
  external bool get isViewportUnconstrained;
  external set isViewportUnconstrained(bool n);
  external dynamic get easing;
  external set easing(dynamic n);
  external int get duration;
  external set duration(int n);
  external dynamic get runCount;
  external set runCount(dynamic n);
  external Function(Animation) get finished;
  external set finished(Function(Animation) n);
  external bool get reversible;
  external set reversible(bool n);

  external void add(dynamic diagram, String pos, dynamic a, dynamic b);
  external void start();
  external void stop();

  external factory Animation();
}

/// https://gojs.net/latest/api/symbols/Picture.html
@JS()
class Picture extends GraphObject {
  @JS('Uniform')
  external static dynamic get uniform;

  external set imageStretch(dynamic n);
  external dynamic get imageStretch;

  external set source(String n);
  external String get source;

  external factory Picture();
}

/// https://gojs.net/latest/api/symbols/GraphObject.html
@JS()
class GraphObject {
  external static dynamic get Fill;

  external bool get visible;
  external set visible(bool n);
  @JS('Horizontal')
  external static dynamic get horizontal;
  @JS('Vertical')
  external static dynamic get vertical;
  external void bind(Binding n);
  external set name(String n);
  external dynamic get fill;
  external set fill(dynamic n);
  external String get background;
  external set background(String n);
  external dynamic get stretch;
  external set stretch(dynamic n);
  external Spot get alignment;
  external set alignment(Spot n);
  external Spot get alignmentFocus;
  external set alignmentFocus(Spot n);
  external String get stroke;
  external set stroke(String n);
  external double get strokeWidth;
  external set strokeWidth(double n);
  external set toolTip(Adornment n);
  external Adornment get toolTip;
  external Part get part;
  external Panel? get panel;
  external set segmentIndex(dynamic n);
  external int get segmentIndex;
  external set segmentFraction(double n);
  external double get segmentFraction;
  external set position(Point n);
  external Point get position;
  external bool get toLinkableDuplicates;
  external set toLinkableDuplicates(bool n);
  external bool get fromLinkableDuplicates;
  external set fromLinkableDuplicates(bool n);

  external String get portId;
  external set portId(String n);
  external String get cursor;
  external set cursor(String n);
  external Spot get fromSpot;
  external set fromSpot(Spot n);
  external Spot get toSpot;
  external set toSpot(Spot n);
  external bool get fromLinkable;
  external set fromLinkable(bool n);
  external bool get toLinkable;
  external set toLinkable(bool n);
  external dynamic get margin;
  external set margin(dynamic n);
  external Adornment get selectionAdornmentTemplate;
  external set selectionAdornmentTemplate(Adornment n);

  external Function([dynamic e, dynamic port, dynamic k]) get mouseEnter;
  external set mouseEnter(Function([dynamic e, dynamic port, dynamic k]));
  external Function([dynamic e, dynamic port, dynamic k]) get mouseLeave;
  external set mouseLeave(Function([dynamic e, dynamic port, dynamic k]));

  external dynamic get width;
  external set width(dynamic n);
  external dynamic get height;
  external set height(dynamic n);
  external Size get desiredSize;
  external set desiredSize(Size n);
  external Size get minSize;
  external set minSize(Size n);

  external num get opacity;
  external set opacity(num n);

  external int get toMaxLinks;
  external set toMaxLinks(int n);
  external int get fromMaxLinks;
  external set fromMaxLinks(int n);
  external Rect get actualBounds;
  external Rect get measuredBounds;
  external Rect get naturalBounds;

  external Diagram? get diagram;

  external factory GraphObject();
}

Map<GraphObject, StreamController<GraphObject>>? _onSelects;
Map<GraphObject, Map<Diagram, StreamController<GraphObject>>>? _onDrops;

extension GraphObjectAdvanced on GraphObject {
  set marginNum(double n) => margin = n;
  double get marginNum => margin as double;
  set marginated(Margin n) => margin = n;
  Margin get marginated => margin as Margin;
  void fullSegmentation() => segmentIndex = nan;
  Rectangle get windowPosition {
    if (panel == null || panel == this || panel == diagram) {
      final d = diagram!;
      var pos = d.transformDocToView(position);
      var clr = d.div.getBoundingClientRect();
      /*window.console.log('windowPositionPart');
      window.console.log(position);
      window.console.log(actualBounds);
      window.console.log(pos);
      window.console.log(clr);*/
      return Rectangle(pos.x + clr.left, pos.y + clr.top, actualBounds.width,
          actualBounds.height);
    } else {
      //window.console.log('$measuredBounds\n $actualBounds\n $naturalBounds');
      var parw = panel!.windowPosition;

      return Rectangle(parw.left + actualBounds.x, parw.top + actualBounds.y,
          actualBounds.width, actualBounds.height);
    }
  }

  Stream<GraphObject> get onSelect {
    final selects = _onSelects ??= {};

    if (selects[this] == null) {
      final _onChanged = allowInterop((DiagramEvent ev) => _jsFn(() {
            var me = ev.diagram.selection.contains(this);

            if (me) {
              selects[this]!.add(this);
            }
          }));
      void start() {
        diagram!.addDiagramListener('ChangedSelection', _onChanged);
      }

      void stop() {
        diagram!.removeDiagramListener('ChangedSelection', _onChanged);
        selects.remove(this);
      }

      selects[this] = StreamController<GraphObject>.broadcast(
          onListen: start, onCancel: stop);
    }

    return selects[this]!.stream;
  }

  Stream<GraphObject> onDropTo(Diagram toDiagram) {
    final drops = _onDrops ??= {};
    final myDrops = drops[this] ??= {};

    if (myDrops[toDiagram] == null) {
      var _onDropped = allowInterop((DiagramEvent ev) {
        var iDropped = (ev.parameter as Diagram).selection.contains(this);

        if (iDropped) {
          myDrops[toDiagram]!.add(this);
        }
      });
      void start() {
        toDiagram.addDiagramListener('ExternalObjectsDropped', _onDropped);
      }

      void stop() {
        toDiagram.removeDiagramListener('ExternalObjectsDropped', _onDropped);
      }

      myDrops[toDiagram] = StreamController<GraphObject>.broadcast(
          onListen: start, onCancel: stop);
    }

    return myDrops[toDiagram]!.stream;
  }
}

/// https://gojs.net/latest/api/symbols/Rect.html
@JS()
class Rect {
  external num get width;
  external num get height;
  external num get bottom;
  external num get right;
  external num get x;
  external num get y;
  external Rect copy();
  external Rect subtractMargin(dynamic margin);
  external Point get position;
  external Size get size;

  external factory Rect(num x, num y, num w, num z);
}

/// https://gojs.net/latest/api/symbols/Panel.html
@JS()
class Panel extends GraphObject {
  @JS('Auto')
  external static dynamic get auto;
  @JS('Grid')
  external static dynamic get grid;
  @JS('Position')
  external static dynamic get Position;
  @JS('Spot')
  external static dynamic get spot;
  @JS('Table')
  external static dynamic get table;
  @JS('Horizontal')
  external static dynamic get horizontal;
  @JS('Vertical')
  external static dynamic get vertical;
  external GraphObject findObject(String arg);
  external void add(GraphObject element);
  external set type(dynamic n);
  external dynamic get type;
  external int get row;
  external set row(int n);
  external int get column;
  external set column(int n);
  external set itemTemplate(Panel n);
  external dynamic get data;
  external Size get gridCellSize;
  external set gridCellSize(Size n);
  external Point get gridOrigin;
  external set gridOrigin(Point n);
  external GraphObject elt(int pos);

  external factory Panel();
}

@JS('Panel')
class ButtonPanel extends Panel {
  external void Function(dynamic, dynamic) get click;
  external set click(void Function(dynamic, dynamic) n);

  external factory ButtonPanel();
}

extension AdvancedPanel on Panel {
  void addAll(Iterable<GraphObject> els) {
    for (var el in els) {
      add(el);
    }
  }
}

/// https://gojs.net/latest/api/symbols/Part.html
@JS()
class Part extends Panel {
  external set locationSpot(Spot n);
  external Spot get locationSpot;
  external set locationObjectName(String n);
  external set selectionObjectName(String n);
  external bool get selectionAdorned;
  external set selectionAdorned(bool n);
  external bool get selectable;
  external set selectable(bool n);
  external bool get isSelected;
  external set isSelected(bool n);
  external String get layerName;
  external set layerName(String n);
  external set location(Point n);
  external Point get location;
  external set dragComputation(Point Function(Part, Point, Point) fn);
  external Point Function(Part, Point, Point) get dragComputation;

  external factory Part();
}

@JS()
@anonymous
class LinkData {
  // {"from":1, "to":2, "fromPort":"B", "toPort":"T"},
  external String get from;
  external set from(String n);
  external String get to;
  external set to(String n);
  external String get fromPortId;
  external set fromPortId(String n);
  external String get toPortId;
  external set toPortId(String n);
  external String get category;
  external set category(String n);
  external Node get fromNode;
  external set fromNode(Node n);
  external Node get toNode;
  external set toNode(Node n);
  external set points(Iterable<double> n);
  external Iterable<double> get points;

  external factory LinkData(
      {String from,
      String to,
      String fromPortId,
      String toPortId,
      String category,
      Node fromNode,
      Node toNode,
      Iterable<double> points});
}

typedef FnPortChanged = void Function(
    Link thisLink, GraphObject oldPort, GraphObject newPort);

/// https://gojs.net/latest/api/symbols/Link.html
@JS()
class Link extends Part {
  @JS('Orthogonal')
  external static dynamic get orthogonal;
  @JS('AvoidsNodes')
  external static dynamic get avoidsNodes;
  @JS('JumpOver')
  external static dynamic get jumpOver;
  @JS('Bezier')
  external static dynamic get bezier;
  @JS('JumpGap')
  external static dynamic get jumpGap;
  external Node get fromNode;
  external Node get toNode;

  external num get smoothness;
  external set smoothness(num n);
  external num get toEndSegmentLength;
  external set toEndSegmentLength(num n);
  external num get fromEndSegmentLength;
  external set fromEndSegmentLength(num n);
  external num get curviness;
  external set curviness(num n);
  external dynamic get routing;
  external set routing(dynamic n);
  external dynamic get curve;
  external set curve(dynamic n);
  external int get toShortLength;
  external set toShortLength(int n);
  external int get corner;
  external set corner(int n);
  external bool get relinkableFrom;
  external set relinkableFrom(bool n);
  external bool get relinkableTo;
  external set relinkableTo(bool n);
  external bool get reshapable;
  external set reshapable(bool n);
  external bool get resegmentable;
  external set resegmentable(bool n);
  external bool get selectionAdorned;
  external set fromPortId(String n);
  external String get fromPortId;
  external set toPortId(String n);
  external String get toPortId;
  external set selectionAdorned(bool n);
  external FnPortChanged get fromPortChanged;
  external set fromPortChanged(FnPortChanged n);
  external FnPortChanged get toPortChanged;
  external set toPortChanged(FnPortChanged n);
  external set points(GoList<Point> n);
  external GoList<Point> get points;
  external Shape get path;
  external set path(Shape n);

  external factory Link();
}

typedef LinkValidationFn = bool Function(Node fromNode, GraphObject fromPort,
    Node toNode, GraphObject toPort, Link link);

/// https://gojs.net/latest/api/symbols/Iterable.html
@JS('Iterable')
abstract class GoIterable<T> {
  external int get count;
  external T get first;
  external Iterator<T> get iterator;

  external factory GoIterable();
}

@JS('List')
class GoList<T> {
  external Iterator<T> get iterator;
}

/// https://gojs.net/latest/api/symbols/Iterator.html
@JS()
abstract class Iterator<T> implements GoIterable<T> {
  external T get value;
  external bool next();
  external void reset();
}

extension AdvancedIterator<T> on Iterator<T> {
  Iterable<T> toList() {
    List<T> ret = [];
    reset();

    while (next()) {
      ret.add(value);
    }
    return ret;
  }

  Iterable<T> where(bool Function(T item) fn) {
    List<T> ret = [];
    reset();

    while (next()) {
      if (fn(value)) {
        ret.add(value);
      }
    }
    return ret;
  }

  T? firstWhere(bool Function(T item) fn) {
    reset();

    while (next()) {
      if (fn(value)) {
        return value;
      }
    }
    return null;
  }
}

/// https://gojs.net/latest/api/symbols/Node.html
@JS()
class Node extends Part {
  external LinkValidationFn get linkValidation;
  external set linkValidation(LinkValidationFn n);
  external Iterator<Link>? get linksConnected;

  external factory Node();
}

extension AdvancedNode on Node {
  Iterable<Link> get links => linksConnected?.toList() ?? [];
}

@JS()
class LinkEvent {
  external dynamic get subject;
}

/// https://gojs.net/latest/api/symbols/Margin.html
@JS()
class Margin {
  external factory Margin(double x, double y, [double w, double z]);
}

/// https://gojs.net/latest/api/symbols/Spot.html
@JS()
class Spot {
  @JS('BottomRight')
  external static Spot get bottomRight;
  @JS('BottomLeft')
  external static Spot get bottomLeft;
  @JS('TopLeft')
  external static Spot get topLeft;
  @JS('TopRight')
  external static Spot get topRight;
  @JS('TopCenter')
  external static Spot get topCenter;
  @JS('Center')
  external static Spot get center;
  @JS('Top')
  external static Spot get top;
  @JS('Bottom')
  external static Spot get bottom;
  @JS('Right')
  external static Spot get right;
  @JS('Left')
  external static Spot get left;
  @JS('TopSide')
  external static Spot get topSide;
  @JS('LeftSide')
  external static Spot get leftSide;
  @JS('RightSide')
  external static Spot get rightSide;
  @JS('BottomSide')
  external static Spot get bottomSide;

  external bool equals(Spot n);
  external int get x;
  external int get y;
  external int get offsetX;
  external int get offsetY;
  external bool get s;

  external factory Spot([double x, double y, double offx, double offy]);
}

/// https://gojs.net/latest/api/symbols/DraggingTool.html
@JS()
class DraggingTool extends Tool {
  external bool get dragsTree;
  external set dragsTree(bool n);
  external bool get isEnabled;
  external set isEnabled(bool n);

  external factory DraggingTool();
}

@JS('GraphObject.make')
external dynamic _make(dynamic arg1, [dynamic arg2, dynamic arg3]);

Adornment makeToolTip() => _make('ToolTip');

ButtonPanel makeButton() => _make('Button');

/// https://gojs.net/latest/api/symbols/Adornment.html
@JS()
class Adornment extends Part {
  external factory Adornment();
}

/// https://gojs.net/latest/api/symbols/Diagram.html
@JS()
class Diagram {
  external Model get model;
  external set model(Model n);
  external ToolManager get toolManager;
  external set toolManager(ToolManager n);
  external GoMap<String, Part> get nodeTemplateMap;
  external set nodeTemplateMap(GoMap<String, Part> n);
  external GoMap<String, Part> get linkTemplateMap;
  external set linkTemplateMap(GoMap<String, Part> n);
  external Part get nodeTemplate;
  external set nodeTemplate(Part n);
  external Link get linkTemplate;
  external set linkTemplate(Link link);
  external Panel get grid;
  external set grid(Panel link);
  external Point get position;
  external set position(Point pos);
  external set initialContentAlignment(Spot point);
  external Spot get initialContentAlignment;
  external set contentAlignment(Spot point);
  external Spot get contentAlignment;
  external bool get isReadOnly;
  external set toolTip(Adornment n);
  external Adornment get toolTip;
  external void addDiagramListener(String event, Function(DiagramEvent event));
  external void removeDiagramListener(
      String event, Function(DiagramEvent event));
  external GoSet<GraphObject> get selection;
  external void clearSelection([bool skipsEvents]);
  external void clear();
  external void select(GraphObject part);
  external set maxSelectionCount(int n);
  external int get maxSelectionCount;
  external set padding(int n);
  external int get padding;
  external Spot get initialDocumentSpot;
  external set initialDocumentSpot(Spot n);
  external Spot get initialViewportSpot;
  external set initialViewportSpot(Spot n);
  external void requestUpdate();
  external Iterator<Node> get nodes;
  external Point transformDocToView(Point point);
  external Margin get autoScrollRegion;
  external set autoScrollRegion(Margin margin);
  external set allowVerticalScroll(bool n);
  external bool get allowVerticalScroll;
  external set allowHorizontalScroll(bool n);
  external bool get allowHorizontalScroll;
  external set allowZoom(bool n);
  external bool get allowZoom;
  external set initialPosition(Point n);
  external Point get initialPosition;
  external set viewSize(Size n);
  external Size get viewSize;
  external Rect get viewportBounds;
  external Rect get fixedBounds;
  external set fixedBounds(Rect n);
  external void centerRect(Rect n);
  external void scroll(dynamic unit, String dir, [num amount]);
  external Rect get documentBounds;
  external DraggingTool get draggingTool;

  external Part findNodeForKey(dynamic key);
  external Link findLinkForData(dynamic data);
  external void remove(Part part);
  external Element get div;
  external set div(Element element);
  external void add(Part part);

  external AnimationManager get animationManager;

  external factory Diagram(Element element);
}

extension AdvancedDiagram on Diagram {
  @JS('LinkDrawn')
  external set linkDrawn(LinkEventFn n);
  @JS('LinkDrawn')
  external LinkEventFn get linkDrawn;
  @JS('LinkRelinked')
  external set linkRelinked(LinkEventFn n);
  @JS('LinkRelinked')
  external LinkEventFn get linkRelinked;
  @JS('InitialAnimationStarting')
  external Function(DiagramEvent ev) get initialAnimationStarting;
  @JS('InitialAnimationStarting')
  external set initialAnimationStarting(Function(DiagramEvent ev) n);
  @JS('undoManager.isEnabled')
  external bool get undoManagerEnabled;
  @JS('undoManager.isEnabled')
  external set undoManagerEnabled(bool n);

  void turnStatic({Rect? rect}) {
    var cli = div.getBoundingClientRect();
    var bounds = documentBounds;
    fixedBounds =
        rect ?? Rect(bounds.x * -1, bounds.y * -1, cli.width, cli.height);

    bounds = fixedBounds;

    allowHorizontalScroll = false;
    allowVerticalScroll = false;
    allowZoom = false;
    requestUpdate();
  }
}

/// https://gojs.net/latest/api/symbols/GraphLinksModel.html
@JS()
class GraphLinksModel extends Model {
  external String get linkFromPortIdProperty;
  external set linkFromPortIdProperty(String n);
  external String get linkToPortIdProperty;
  external set linkToPortIdProperty(String n);
  external set linkCategoryProperty(Function(dynamic data, [dynamic key]) n);
  external factory GraphLinksModel([Iterable items, Iterable indexed]);
  external void addLinkData(dynamic data);
  external void removeLinkData(dynamic data);
  external dynamic getKeyForLinkData();
}

/// https://gojs.net/latest/api/symbols/Model.html
@JS()
class Model {
  external static Model fromJson(dynamic obj);
  external List<dynamic> get nodeDataArray;
  external set nodeDataArray(List<dynamic> n);
  external List<dynamic> get linkDataArray;
  external set linkDataArray(List<dynamic> n);
  external void commit(Function(Model model) fn);
  external void setDataProperty(dynamic data, String prop, dynamic val);
  external void assignAllDataProperties(dynamic data, dynamic props);
  external void addNodeData(dynamic data);
  external void removeNodeData(dynamic data);
  external void addChangedListener(Function(ChangedEvent) fn);

  external factory Model();
}

class ModelAdvanced {
  static Model parseJson(String buf) => Model.fromJson(buf);
  static Model loadJson(JsObject buf) => Model.fromJson(buf);
}

@JS()
class ChangedEvent {
  external static dynamic get Insert;
  external dynamic get change;
  external Diagram get diagram;
  external bool get isTransactionFinished;
  external Model get model;
  external String get modelChange;
  external dynamic get newValue;
  external dynamic get newParam;
  external dynamic get object;
  external String get propertyName;
}

@JS()
@anonymous
class NodeData {
  external String get key;

  external factory NodeData({String key, Point location});
}

Point stayInFixedArea(Part part, Point pt, Point gridpt) {
  var diagram = part.diagram;

  if (diagram == null) {
    //print('NoDiagram, returning point $pt');
    return pt;
  }

  // compute the document area without padding
  var v = diagram.documentBounds.copy();
  v.subtractMargin(diagram.padding);
  // get the bounds of the part being dragged
  var b = part.actualBounds;
  var loc = part.location;
  // now limit the location appropriately
  var x = math.max(v.x, math.min(pt.x, v.right - b.width)) + (loc.x - b.x);
  var y = math.max(v.y, math.min(pt.y, v.bottom - b.height)) + (loc.y - b.y);
  var ret = Point(x, y);
  return ret;
}
