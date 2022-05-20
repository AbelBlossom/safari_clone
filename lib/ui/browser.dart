import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/provider/position_provider.dart';
import 'package:safari_clone/ui/common/widgets/background.dart';
import 'package:safari_clone/ui/components/browser/overview.dart';
import 'package:safari_clone/ui/components/browser/view_list.dart';
import 'package:safari_clone/ui/components/tab_bar/tab_bar.dart';
import 'package:safari_clone/ui/components/tab_bar/tab_bar_switcher.dart';
import 'package:safari_clone/provider/ui_manager.dart';

class Browser extends StatefulWidget {
  const Browser({Key? key}) : super(key: key);

  @override
  State<Browser> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final pos = context.read<PositionProvider>();
    final ui = context.read<UIManager>();
    return Scaffold(
      body: CupertinoScaffold(
        // transitionBackgroundColor: CupertinoColors.white,
        // topRadius: const Radius.circular(20),
        body: CupertinoPageScaffold(
          child: Stack(
            children: [
              const Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: BrowserBackground(),
              ),
              Positioned.fill(
                child: GestureDetector(
                    onPanUpdate: (_det) {
                      if (ui.overviewSwitcher.value == 1) {
                        var pageY = pos.pageY;
                        pos.pageY = _det.delta.dy + pageY;
                      }
                    },
                    onPanDown: (_) {
                      pos.pageY = pos.pageY;
                    },
                    onPanEnd: (_det) {
                      if (ui.overviewSwitcher.value == 1) {
                        //TODO: scroll to the correct position
                        if (pos.pageY > 0) {
                          pos.pageY = withSpring(0.0);
                          return;
                        }
                        var y = pos.pageY;
                        var velocity = _det.velocity.pixelsPerSecond.dy;
                        var v = velocity.interpolate([-5000.0, 5000.0],
                            [-1000.0, 1000.0], Extrapolate.CLAMP).toDouble();
                        var time = v.abs().interpolate([0, 1000.0],
                            [100.0, 500.0], Extrapolate.CLAMP).toInt();
                        pos.pageY = withTiming(
                          min((y + v), 0.0),
                          duration: time,
                          curve: Curves.linear,
                        );
                      }
                    },
                    child: const TabViewList()),
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: TabBarSwitcher(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
