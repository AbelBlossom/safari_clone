import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/ui/provider/ui_manager.dart';

class TabViewList extends StatefulWidget {
  const TabViewList({Key? key}) : super(key: key);

  @override
  State<TabViewList> createState() => _TabViewListState();
}

class _TabViewListState extends State<TabViewList> {
  @override
  Widget build(BuildContext context) {
    final uiManager = context.watch<UIManager>();
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: uiManager.offsetListener,
      builder: (_, child) {
        return Stack(
            children: uiManager.tabs.map((index) {
          var diff = uiManager.page - index;
          // var offset = di
          return Positioned(
              top: 0,
              left: 0,
              child: Transform.translate(
                offset: Offset(diff * size.width, 0),
                child: Container(
                  width: size.width,
                  height: size.height,
                  color: index % 2 == 0
                      ? CupertinoColors.activeBlue
                      : CupertinoColors.activeGreen,
                ),
              ));
        }).toList());
      },
    );
  }
}
