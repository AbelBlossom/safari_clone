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
            children: const [
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: BrowserBackground(),
              ),
              Positioned.fill(
                child: TabViewList(),
              ),
              Positioned(
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
