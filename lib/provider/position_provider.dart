import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:safari_clone/models/position.dart';

class PositionProvider extends ChangeNotifier {
  List<Position> pos =
      [0, 1, 2, 3, 4].map((_) => Position()).toList().toList(growable: true);

  ValueNotifier pageX = ValueNotifier(0);

  late List<Position> prev;
  PositionProvider() {
    prev = pos;
  }

  Future<void> resetPrev(Size size, int page) {
    var completer = Completer<void>();
    List<Position> _p = [];
    for (var i = 0; i < prev.length; i++) {
      var diff = page - i;
      var x = -1 * (diff * size.width);
      var _prev = Position();
      _prev.height = size.height;
      _prev.scale = 1.0;
      _prev.x = x;
      _prev.y = 0;
      _prev.radius = 0;
      _prev.width = size.width;
      _p.add(_prev);

      if (i == prev.length - 1) {
        prev = _p;
        completer.complete();
      }
    }

    return completer.future;
  }

  preserve() {
    prev = pos;
  }
}
