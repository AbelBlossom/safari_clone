import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/ui/common.dart';
import 'package:safari_clone/ui/components/browser/overview.dart';
import 'package:safari_clone/ui/components/tab_bar/tab_item.dart';
import 'dart:math' as math;

import 'package:safari_clone/ui/provider/ui_manager.dart';

class TabSlider extends StatefulWidget {
  const TabSlider({Key? key}) : super(key: key);

  @override
  State<TabSlider> createState() => _TabSliderState();
}

class _TabSliderState extends State<TabSlider> with TickerProviderStateMixin {
  late Tweenable _offset;
  late Tweenable _iPage;
  late Tweenable _y;
  double _startY = 0.0;

  @override
  void initState() {
    _offset = 0.0.asTweenable(this);
    _iPage = 0.0.asTweenable(this);
    _y = 1.0.asTweenable(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width - CONSTANTS.TABITEM_OFFSET;
    final uiManager = context.read<UIManager>();
    uiManager.initPage(_iPage);
    uiManager.initHPos(_y);
    return GestureDetector(
      onPanStart: (det) {
        _startY = det.globalPosition.dy + 100;
      },
      onPanUpdate: (details) {
        _offset.value += details.delta.dx;
        uiManager.setY(
            details.globalPosition.dy.interpolate([0, _startY], [0.0, 1.0]));
      },
      onPanEnd: (_det) {
        var toPage = uiManager.page.round();
        var to = math.max(toPage * w, 0.0);
        _offset.value = withSpring(to);
        uiManager.setY(withSpring(1.0));
        _iPage.value = 0;
        uiManager.selectedPage = toPage;

        uiManager.gotoFunc = (int page) {
          var to = math.max(math.min(page, uiManager.tabSize) * w, 0.0);
          _offset.value = withSpring(to);
          uiManager.setY(withSpring(1.0));
          _iPage.value = 0;
          uiManager.selectedPage = to.toInt();
        };

        openOverView() {
          uiManager.navigatorKey.currentState?.push(
            PageRouteBuilder(
                maintainState: true,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return ScaleTransition(
                      scale: animation, child: const TabsOverview());
                }),
          );
        }

        if (uiManager.yVal < 0.5) {
          return openOverView();
        }

        if (_det.velocity.pixelsPerSecond.dy.abs() > 2000) {
          if (uiManager.yVal < 0.7) {
            // uiManager.navigatorKey.currentState?.pushNamed("/overview");
            return openOverView();
          }
        }

        // uiManager.gotoPage(toPage);
      },
      child: AnimatedBuilder(
        animation: _offset.notifier,
        builder: (context, child) {
          return Stack(
            children: uiManager.tabs.map((index) {
              uiManager.page = _offset.interpolate(
                  [0.0, w * uiManager.tabSize.toDouble()],
                  [0.0, uiManager.tabSize.toDouble()]);

              //FIXME: maybe there is a better way to handle this, lol
              SchedulerBinding.instance?.addPostFrameCallback((_) {
                uiManager.offsetListener.value = _offset.value;
              });
              var diff = uiManager.page - index;
              // print("page is ${uiManager.page}");
              return Transform.translate(
                offset: Offset(diff * w, 0),
                child: CupertinoContextMenu(actions: const [
                  CupertinoContextMenuAction(
                    child: Text("Here"),
                  ),
                ], child: const TabItem()),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
