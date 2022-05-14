import 'package:flutter/cupertino.dart';
import 'package:remaths/remaths.dart';

class UIManager {
  // Testing Tabs
  // the numbers indicates the index of the tabs
  List<int> tabs = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // this returns the number of tabs counting from 0
  int get tabSize => tabs.length - 1;
  int selectedPage = 0;

  // this value holds the double from the animation geture
  // this value is ranges from [0 -> len of tabs]
  Tweenable? _page;

  // this value ranges from [0,0] interpolation of [0, ScreenHeight]
  Tweenable? y;

  setY(dynamic val) {
    if (y != null) {
      y?.value = val;
    }
  }

  double get yVal => y != null ? y!.value : 1.0;

  ValueNotifier<double> offsetListener = ValueNotifier<double>(0.0);
  ValueNotifier<double> yListener = ValueNotifier<double>(0.0);

  void Function(int page)? _gotoPage;
  set gotoFunc(void Function(int page) func) {
    _gotoPage = func;
  }

  gotoPage(int page) {
    if (_gotoPage == null) return;
    _gotoPage!(page);
  }

  double get page => _page == null ? 0.0 : _page!.value;

  initPage(Tweenable _value) {
    if (!_hasPage) {
      _page = _value;
    }
  }

  initHPos(Tweenable _val) {
    if (y == null) {
      y = _val;
      y!.addEventListener((value) {
        yListener.value = value;
      });
    }
  }

  set page(dynamic value) {
    // print("setting page to $page");
    if (_page == null) return;
    _page?.value = value;
  }

  bool get _hasPage => _page != null;
}
