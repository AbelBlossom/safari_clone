import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safari_clone/provider/ui_manager.dart';
import 'package:safari_clone/ui/common/constants.dart';
import 'package:safari_clone/ui/common/widgets/blur_widget.dart';
import 'package:safari_clone/ui/components/tab_bar/tab_slider.dart';
import 'package:provider/provider.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  @override
  Widget build(BuildContext context) {
    final uiManager = context.read<UIManager>();
    return Container(
      height: CONSTANTS.TABBAR_HEIGHT,
      color: Colors.white60,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BlurFilter(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: const Icon(CupertinoIcons.back),
                      onPressed: () {},
                    ),
                    CupertinoButton(
                      child: const Icon(CupertinoIcons.forward),
                      onPressed: () {},
                    ),
                    CupertinoButton(
                      child: const Icon(CupertinoIcons.share),
                      onPressed: () {},
                    ),
                    CupertinoButton(
                      child: const Icon(CupertinoIcons.book),
                      onPressed: () {},
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: GestureDetector(
                        onLongPress: () {
                          print("long press");
                        },
                        child: CupertinoButton(
                          child: const Icon(CupertinoIcons.square_on_square),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: CONSTANTS.TABITEM_OFFSET / 2,
            right: CONSTANTS.TABITEM_OFFSET / 2,
            child: Center(
              //TODO: uncomment this when tab slider is ready
              // child: TabSlider(),
              child: TabSlider(),
            ),
          ),
        ],
      ),
    );
  }
}
