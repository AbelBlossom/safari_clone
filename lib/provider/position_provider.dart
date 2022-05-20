import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/models/position.dart';

class PositionProvider {
  List<Position> pos =
      [0, 1, 2, 3, 4].map((_) => Position()).toList().toList(growable: true);

  Tweenable? _pageY;
  bool isAnimating = true;

  late List<Position> prev;
  PositionProvider() {
    prev = pos;
  }

  set pageY(dynamic value) {
    if (_pageY == null) {
      return;
    }
    _pageY!.value = value;
  }

  double get pageY {
    if (_pageY == null) {
      return 0.0;
    }
    return _pageY!.value;
  }

  initPageY(Tweenable y) {
    _pageY = y;
    _pageY!.addEventListener((value) {
      yListener.value = value;
      if (value == 1) {
        isAnimating = false;
      }
    });
  }

  ValueNotifier<double> yListener = ValueNotifier(0.0);

  Future<void> resetPrev(Size size, int page) {
    var completer = Completer<void>();
    List<Position> p = [];
    for (var i = 0; i < prev.length; i++) {
      var diff = page - i;
      var x = -1 * (diff * size.width);
      var pv = Position();
      pv.height = size.height;
      pv.scale = 1.0;
      pv.x = x;
      pv.y = 0;
      pv.radius = 0;
      pv.width = size.width;
      p.add(pv);

      if (i == prev.length - 1) {
        prev = p;

        completer.complete();
      }
    }

    return completer.future;
  }

  preserve() {
    prev = pos.map((p) => p..y = 0).toList();
  }

  addNewTab(Size size) {
    var index = pos.length;
    var _p = Position();
    _p.height = size.height;
    _p.scale = 1.0;
    _p.x = -1 * (index * size.width);
    _p.y = 0;
    _p.radius = 0;
    _p.width = size.width;
    pos.add(_p);
    prev = pos;
  }
}
