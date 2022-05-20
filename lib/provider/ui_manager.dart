import 'package:flutter/cupertino.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/models/position.dart';
import 'package:safari_clone/ui/components/browser/overview.dart';
import 'package:safari_clone/ui/components/tab_bar/tab_slider.dart';

class UIManager extends ChangeNotifier {
  //TODO: make this dynamic and implete the tabs switching
  List<int> tabs = [0, 1, 2, 3, 4];

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // this returns the number of tabs counting from 0
  int get tabSize => tabs.length - 1;
  int selectedPage = 0;

  // this value holds the double from the animation geture
  // this value is ranges from [0 -> len of tabs]
  Tweenable? _page;

  // this value ranges from [0,0] interpolation of [0, ScreenHeight]
  Tweenable? y;

  Tweenable? swap;

  ValueNotifier<double> swapListener = ValueNotifier(0);
  ValueNotifier<double> overviewSwitcher = ValueNotifier(0);

  bool get hasGotoFunc => _gotoPage != null;

  setSwap(int value) {
    if (swap == null) return;
    swap?.value = animTo(value.toDouble());
  }

  setY(dynamic val) {
    if (y != null) {
      y?.value = val;
    }
  }

  double get yVal => y != null ? y!.value : 1.0;

  ValueNotifier<double> offsetListener = ValueNotifier<double>(0.0);
  ValueNotifier<double> yListener = ValueNotifier<double>(0.0);

  void Function(int page, [bool withAnim])? _gotoPage;
  void Function(int index)? closeOverView;
  void Function()? refreshTabs;
  set gotoFunc(void Function(int page, [bool withAnim]) func) {
    _gotoPage = func;
  }

  ScrollController scrollController = ScrollController();

  gotoPage(int page, [bool withAnim = true]) {
    if (_gotoPage == null) return;
    _gotoPage!(page, withAnim);
    if (refreshTabs != null) {
      refreshTabs!();
    }
  }

  double get page => _page == null ? 0.0 : _page!.value;

  initPage(Tweenable _value) {
    if (!_hasPage) {
      _page = _value;
    }
  }

  createNewTab() {
    tabs.add(tabs.length);
    selectedPage = tabs.length - 1;
    if (refreshTabs != null) {
      refreshTabs!();
    }
  }

  initSwap(Tweenable _val) {
    if (swap == null) {
      swap = _val;
      _val.addEventListener((value) {
        swapListener.value = value;
      });
    }
  }

  initOverviewSwap(Tweenable _val) {
    _val.addEventListener((value) {
      // print("changed");
      overviewSwitcher.value = value;
    });
  }

  initHPos(Tweenable _val) {
    if (y == null) {
      y = _val;
      _val.addEventListener((value) {
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
