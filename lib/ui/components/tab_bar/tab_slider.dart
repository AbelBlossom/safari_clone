import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/ui/common.dart';
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

  @override
  void initState() {
    _offset = 0.0.asTweenable(this);
    _iPage = 0.0.asTweenable(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - CONSTANTS.TABITEM_OFFSET);
    final uiManager = context.read<UIManager>();
    uiManager.initPage(_iPage);
    return GestureDetector(
      onPanUpdate: (details) {
        // print("calld");
        _offset.value += details.delta.dx;
      },
      onPanEnd: (_det) {
        var to = math.max(
            math.min(uiManager.page.round(), uiManager.tabSize) * w, 0.0);
        _offset.value = withSpring(to);
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
              print("page is ${uiManager.page}");
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
