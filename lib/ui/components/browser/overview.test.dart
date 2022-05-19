import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/models/position.dart';
import 'package:safari_clone/provider/position_provider.dart';
import 'package:safari_clone/ui/common/widgets/background.dart';
import 'package:safari_clone/provider/ui_manager.dart';

class TabViewTest extends StatefulWidget {
  const TabViewTest({Key? key}) : super(key: key);

  @override
  State<TabViewTest> createState() => _TabViewTestState();
}

class _TabViewTestState extends State<TabViewTest> {
  @override
  Widget build(BuildContext context) {
    final uiManager = context.read<UIManager>();
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: Listenable.merge([
        uiManager.offsetListener,
        uiManager.yListener,
        uiManager.overviewSwitcher,
      ]),
      builder: (_, child) {
        return Stack(
          children: [
            ...uiManager.tabs
                .map((index) => index == uiManager.selectedPage
                    ? Container()
                    : _TabViewBuilder(key: GlobalKey(), index: index))
                .toList(),
            _TabViewBuilder(index: uiManager.selectedPage),
          ],
        );
      },
    );
  }
}

class _TabViewBuilder extends StatelessWidget {
  final int index;
  _TabViewBuilder({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var uiManager = context.read<UIManager>();

    var posProvider = context.read<PositionProvider>();
    var pos = posProvider.pos[index];
    var prev = posProvider.prev[index];

    var diff = uiManager.page - index;

    if (uiManager.overviewSwitcher.value > 0) {
      List<Position> _p = [];
      var line = (((index % 2 == 0 ? index + 1 : index) + 1) / 2) - 1;
      final ov = uiManager.overviewSwitcher.value;
      // print(ov);
      var p = 20;
      var p2 = p / 2;
      var h = size.height / 2;
      pos.scale = ov.interpolate([0, 1], [prev.scale, 0.5]);
      pos.height = ov.interpolate([0, 1], [prev.height, h]);
      pos.radius = ov.interpolate([0, 1], [prev.radius, 50]);
      pos.width = ov.interpolate([0, 1], [prev.width, size.width - p]);
      pos.y = ov.interpolate([0, 1], [0, (line * (h + 20)) - ((h / 2) - p)]);
      pos.x = ov.interpolate(
        [0, 1],
        [prev.x, index % 2 == 0 ? -(size.width / 2) + p : (size.width / 2) + p],
      );
    } else {
      // print("else hit");
      pos.y = 0;
      pos.scale =
          uiManager.yVal.interpolate([0.0, 1.0], [0.5, 1.0], Extrapolate.CLAMP);

      pos.radius = uiManager.yVal
          .interpolate([0.0, 1.0], [50.0, 0.0], Extrapolate.CLAMP);
      pos.x = -1 * (diff * size.width);
      pos.width = size.width - pos.radius;

      pos.height = size.height * pos.scale;
    }

    return Positioned(
      top: 0,
      left: 0,
      child: Transform.scale(
        scale: pos.scale,
        child: Transform.translate(
          offset: Offset(pos.x, pos.y),
          child: InkWell(
            onTap: uiManager.overviewSwitcher.value > 0
                ? () async {
                    // uiManager.selectedPage = index;
                    // uiManager.page = index;
                    await posProvider.resetPrev(size, index);
                    // print(index);
                    if (uiManager.closeOverView != null) {
                      uiManager.closeOverView!(index);
                    }

                    // Future.delayed(duration)
                  }
                : null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(pos.radius),
              child: IgnorePointer(
                ignoring: uiManager.overviewSwitcher.value > 0,
                child: SizedBox(
                  // margin: EdgeInsets.symmetric(horizontal: 50),

                  width: pos.width,
                  height: pos.height,
                  child: TabContent(index: index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final int index;
  const TabContent({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: index % 2 == 0
            ? CupertinoColors.activeBlue
            : CupertinoColors.activeGreen,
        child: CupertinoButton(
          onPressed: () {},
          child: Text("TRY"),
        ));
  }
}