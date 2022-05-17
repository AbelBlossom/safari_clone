import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:remaths/remaths.dart';
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

  @override
  void initState() {
    _offset = 0.0.asTweenable(this);
    _iPage = 0.0.asTweenable(this);
    _y = 1.0.asTweenable(this);
    swap = 0.0.asTweenable(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width - CONSTANTS.TABITEM_OFFSET;
    final uiManager = context.read<UIManager>();
    uiManager.initPage(_iPage);
    uiManager.initHPos(_y);
    uiManager.initSwap(swap);
    return GestureDetector(
      onPanStart: (det) {
        _startY = det.globalPosition.dy + 100;
      },
      onPanUpdate: (details) {
        //FIXME: animation don't work with single tab
        _offset.value -= details.delta.dx;
        uiManager.setY(
            details.globalPosition.dy.interpolate([0, _startY], [0.0, 1.0]));

        // if (uiManager.page < -0.2) {
        //   print(true);
        // }
      },
      onPanEnd: (_det) {
        if (uiManager.page < -0.6) {
          //TODO: create a new page
        }
        setState(() {
          var toPage = uiManager.page.round();
          var to = math.max(toPage * w, 0.0);
          _offset.value = withSpring(to);
          uiManager.setY(withSpring(1.0));
          _iPage.value = 0;
          uiManager.selectedPage = toPage;
        });

        uiManager.gotoFunc = (int page, [bool withAnim = true]) {
          var to = math.max(math.min(page, uiManager.tabSize) * w, 0.0);
          if (withAnim) {
            _offset.value = withSpring(to);
            uiManager.setY(withSpring(1.0));
          } else {
            _offset.value = to;
            uiManager.setY(1.0);
          }
          _iPage.value = 0;
          uiManager.selectedPage = to.toInt();
        };

        if (uiManager.yVal < 0.5) {
          uiManager.openOverView();
          return;
        }
        // print(_det.velocity.pixelsPerSecond.dy.abs());
        if (_det.velocity.pixelsPerSecond.dy.abs() > 2000) {
          uiManager.openOverView();
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
                  var _co = width.interpolate<double>(
                      [100, item_with], [0, 1], Extrapolate.CLAMP);

                  return Container(
                    width: width,
                    child: NewTabItem(
                      showContent: width > item_with * 0.8,
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
    return Container(
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
      child: showContent
          ? Row(
              children: const [
                Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                  size: 16,
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Text(
                    "Search or Enter website",
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
