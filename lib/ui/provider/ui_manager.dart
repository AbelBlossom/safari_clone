import 'package:flutter/cupertino.dart';
import 'package:remaths/remaths.dart';

class UIManager {
  // Testing Tabs
  // the numbers indicates the index of the tabs
  List<int> tabs = [0, 1, 2, 3, 4];

  // this returns the number of tabs counting from 0
  int get tabSize => tabs.length - 1;

  // this value holds the double from the animation geture
  // this value is ranges from [0 -> len of tabs]
  Tweenable? _page;

  ValueNotifier<double> offsetListener = ValueNotifier<double>(0.0);

  double get page => _page == null ? 0.0 : _page!.value;

  initPage(Tweenable _value) {
    if (!_hasPage) {
      _page = _value;
    }
  }

  set page(dynamic value) {
    // print("setting page to $page");
    if (_page == null) return;
    _page?.value = value;
  }

  bool get _hasPage => _page != null;
}
