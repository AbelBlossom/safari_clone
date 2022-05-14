import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:safari_clone/ui/common/widgets/background.dart';
import 'package:safari_clone/ui/components/browser/overview.dart';
import 'package:safari_clone/ui/components/browser/view_list.dart';
import 'package:safari_clone/ui/components/tab_bar/tab_bar.dart';
import 'package:safari_clone/ui/components/tab_bar/tab_bar_switcher.dart';
import 'package:safari_clone/ui/provider/ui_manager.dart';

class Browser extends StatefulWidget {
  const Browser({Key? key}) : super(key: key);

  @override
  State<Browser> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
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
                child: Navigator(
                  key: context.read<UIManager>().navigatorKey,
                  initialRoute: "/",
                  observers: [
                    HeroController(),
                  ],
                  onGenerateRoute: (settings) {
                    // if (settings.name == "/overview") {
                    //   return MaterialPageRoute(
                    //       maintainState: false,
                    //       builder: (_) => const TabsOverview());
                    // }
                    return MaterialPageRoute(
                        maintainState: false,
                        builder: (_) => const TabViewList());
                  },
                ),
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
