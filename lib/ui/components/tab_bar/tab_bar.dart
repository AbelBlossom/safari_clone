import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:safari_clone/ui/components/tab_bar/tab_item.dart';
import 'package:safari_clone/ui/components/tab_bar/tab_slider.dart';
import 'package:safari_clone/ui/navigation/page_builder.dart';
import 'package:safari_clone/ui/pages/test.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        // height: 110,
        color: Colors.black12,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            children: [
              const TabSlider(),
              // create a row of tabs
              Row(
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
                    child: CupertinoButton(
                      child: const Icon(CupertinoIcons.rectangle_on_rectangle),
                      onPressed: () {
                        // showCupertinoModalBottomSheet(
                        //     expand: true,
                        //     context: context,
                        //     builder: (_) {
                        //       return TestPage();
                        //     });

                        CupertinoScaffold.showCupertinoModalBottomSheet(
                          expand: true,
                          context: context,
                          builder: (context) => TestPage(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
