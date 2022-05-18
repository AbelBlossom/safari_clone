import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/provider/ui_manager.dart';

class TabsOverview extends StatefulWidget {
  const TabsOverview({Key? key}) : super(key: key);

  @override
  State<TabsOverview> createState() => _TabsOverviewState();
}

class _TabsOverviewState extends State<TabsOverview> {
  bool isEnter = true;

  @override
  Widget build(BuildContext context) {
    var uiManager = context.read<UIManager>();
    final ratio = 4 / 5;
    // line = ((page % 2 ==0 ? page+1,page) +1)/2
    final page = uiManager.selectedPage;

    var line = (((page % 2 == 0 ? page + 1 : page) + 1) / 2) - 1;
    // print("$line");

    final width = MediaQuery.of(context).size.width;
    //FIXME: this method does not work appropriately [height of the item]
    final double _height = ((width / 2)) * ratio;
    final _offset = line * _height;
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: ratio,
      restorationId: "_tab_overview_",
      controller: ScrollController(initialScrollOffset: 0),
      padding: const EdgeInsets.all(10),
      children: uiManager.tabs.map((index) {
        return Hero(
          tag: cond(
              cond(
                isEnter,
                [index - 1, index, index + 1].contains(uiManager.selectedPage),
                eq(index, uiManager.selectedPage),
              ),
              "tab_$index",
              "$index"),
          // tag: "tab_$index",
          child: GestureDetector(
            onTap: () {
              if (uiManager.selectedPage != index) {
                // uiManager.selectedPage = index;
                uiManager.gotoPage(index, false);
              }
              // experiment: wait for toToPage Animation to finish
              setState(() {
                uiManager.selectedPage = index;
                isEnter = false;
              });
              // Future.delayed(const Duration(milliseconds: 1000), () {
              uiManager.setSwap(0);
              uiManager.navigatorKey.currentState?.pop();
              // });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: index % 2 == 0
                    ? CupertinoColors.activeBlue
                    : CupertinoColors.activeGreen,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
