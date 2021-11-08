@JS('window')
library window;

import 'package:js/js.dart';

@JS()
external dynamic get undefined;

@JS('NaN')
external num get nan;

@JS('Number.isNaN')
external bool numberIsNaN(n);

@JS('Infinity')
external dynamic get infinity;
