import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/ui/common.dart';
import 'package:safari_clone/ui/components/tab_bar/tab_item.dart';
import 'dart:math' as math;

class TabSlider extends StatefulWidget {
  const TabSlider({Key? key}) : super(key: key);

  @override
  State<TabSlider> createState() => _TabSliderState();
}

class _TabSliderState extends State<TabSlider> with TickerProviderStateMixin {
  late Tweenable _offset;

  double page = 0;

  @override
  void initState() {
    _offset = 0.0.asTweenable(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - CONSTANTS.TABITEM_OFFSET);
    return GestureDetector(
      onPanUpdate: (details) {
        print("calld");
        _offset.value += details.delta.dx;
      },
      onPanEnd: (_det) {
        var to = math.min(page.round(), 4) * w;
        print(to);

        _offset.value = withSpring(to.toDouble());
      },
      child: AnimatedBuilder(
        animation: _offset.notifier,
        builder: (context, child) {
          return Stack(
            children: List.generate(5, (index) {
              page = _offset.interpolate([0.0, w * 4], [0.0, 4.0]);

              var diff = page - index;
              // print("$diff $index");
              return Transform.translate(
                offset: Offset(diff * w, 0),
                child: const TabItem(),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
