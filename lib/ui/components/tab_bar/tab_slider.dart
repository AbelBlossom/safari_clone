import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/provider/position_provider.dart';
import 'package:safari_clone/ui/common/constants.dart';
import 'package:safari_clone/ui/components/browser/overview.dart';
import 'package:safari_clone/ui/components/tab_bar/tab_item.dart';
import 'dart:math' as math;

import 'package:safari_clone/provider/ui_manager.dart';

class TabSlider extends StatefulWidget {
  const TabSlider({Key? key}) : super(key: key);

  @override
  State<TabSlider> createState() => _TabSliderState();
}

class _TabSliderState extends State<TabSlider> with TickerProviderStateMixin {
  late Tweenable _offset;
  late Tweenable _iPage;
  late Tweenable _y;
  late Tweenable swap;
  double _startY = 0.0;
  late Tweenable _overview;

  @override
  void initState() {
    _offset = 0.0.asTweenable(this);
    _iPage = 0.0.asTweenable(this);
    _y = 1.0.asTweenable(this);
    swap = 0.0.asTweenable(this);
    _overview = 0.0.asTweenable(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width - CONSTANTS.TABITEM_OFFSET;
    final uiManager = context.read<UIManager>();
    final pos = context.read<PositionProvider>();
    uiManager.initPage(_iPage);
    uiManager.initHPos(_y);
    uiManager.initSwap(swap);
    uiManager.initOverviewSwap(_overview);
    return GestureDetector(
      onPanStart: (det) {
        _startY = det.globalPosition.dy + 20;
      },
      onPanUpdate: (details) {
        _offset.value -= details.delta.dx;
        uiManager.setY(
            details.globalPosition.dy.interpolate([0, _startY], [0.0, 1.0]));
      },
      onPanEnd: (_det) {
        if (uiManager.page < 0) {
          var to = math.max(0 * w, 0.0);
          _offset.value = withTiming(to);
          uiManager.setY(withTiming(1.0));
          _iPage.value = 0;
          uiManager.selectedPage = 0;
          return;
        }
        if (uiManager.page > uiManager.tabSize + 0.5) {
          pos.addNewTab(size);
          uiManager.createNewTab();
        }
        uiManager.closeOverView = (index) {
          var to = math.max(index * w, 0.0);
          uiManager.setY(1);
          _offset.value = to;
          // if (index != uiManager.selectedPage) {
          //   uiManager.gotoPage(index, false);
          // }

          _overview.value = withTiming(0);
          uiManager.setSwap(0);
          return;
        };

        setState(() {
          var toPage = uiManager.page.round();
          var to = math.max(toPage * w, 0.0);
          _offset.value = withTiming(to);
          uiManager.setY(withTiming(1.0));
          _iPage.value = 0;
          uiManager.selectedPage = toPage;
        });

        uiManager.gotoFunc = (int page, [bool withAnim = true]) {
          var to = math.max(math.min(page, uiManager.tabSize) * w, 0.0);
          if (withAnim) {
            _offset.value = withTiming(to);
            uiManager.setY(withTiming(1.0));
          } else {
            _offset.value = to;
            uiManager.setY(1.0);
          }
          _iPage.value = 0;
          uiManager.selectedPage = page;
        };
        if (_det.velocity.pixelsPerSecond.dy.abs() > 2000 ||
            uiManager.yVal < 0.5) {
          pos.preserve();
          _overview.value = withTiming(1);
          uiManager.setSwap(1);
          return;
        }

        // uiManager.gotoPage(toPage);
      },
      child: AnimatedBuilder(
        animation: _offset.notifier,
        builder: (context, child) {
          return Stack(
            children: [
              ...uiManager.tabs.map((index) {
                uiManager.page = _offset.interpolate<double>(
                    [0.0, w * uiManager.tabSize],
                    [0.0, uiManager.tabSize.toDouble()]);

                //FIXME: maybe there is a better way to handle this, lol
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  uiManager.offsetListener.value = _offset.value;
                });
                var diff = uiManager.page - index;
                // print("page is ${uiManager.page}");
                return Transform.translate(
                  offset: Offset(-(diff * w), 0),
                  child: const TabItem(),
                );
              }).toList(),
              Positioned(
                top: 5,
                right: 0,
                child: Builder(builder: ((context) {
                  final item_with = size.width - CONSTANTS.TABITEM_OFFSET;
                  var width = uiManager.page.interpolate<double>([
                    uiManager.tabSize.toDouble(),
                    uiManager.tabSize.toDouble() + 1.0,
                  ], [
                    0,
                    item_with,
                  ], Extrapolate.CLAMP);
                  var _co = width
                      .interpolate<double>([30, 40], [0, 1], Extrapolate.CLAMP);

                  return Container(
                    width: width,
                    child: Opacity(
                      opacity: _co,
                      child: NewTabItem(
                        showContent: width > item_with * 0.8,
                      ),
                    ),
                  );
                })),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NewTabItem extends StatelessWidget {
  final bool showContent;
  const NewTabItem({Key? key, this.showContent = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
          height: CONSTANTS.TABITEM_HEIGHT,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Icon(CupertinoIcons.add),
          )),
    );
  }
}
