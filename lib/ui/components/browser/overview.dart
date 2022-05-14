import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/ui/components/browser/background.dart';
import 'package:safari_clone/ui/provider/ui_manager.dart';

class TabsOverview extends StatefulWidget {
  const TabsOverview({Key? key}) : super(key: key);

  @override
  State<TabsOverview> createState() => _TabsOverviewState();
}

class _TabsOverviewState extends State<TabsOverview> {
  @override
  Widget build(BuildContext context) {
    var uiManager = context.read<UIManager>();
    print(uiManager.selectedPage);
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 4 / 5,
      restorationId: "_tab_overview_",
      key: const PageStorageKey("Tabs_Overview"),
      padding: const EdgeInsets.all(10),
      children: uiManager.tabs.map((index) {
        return Hero(
          tag: cond(eq(index, uiManager.selectedPage), "tab_$index", "$index"),
          // tag: "tab_$index",
          child: GestureDetector(
            onTap: () {
              if (uiManager.selectedPage != index) {
                uiManager.gotoPage(index);
              }
              setState(() {
                uiManager.selectedPage = index;
              });
              // Future.delayed(const Duration(milliseconds: 3000), () {
              uiManager.navigatorKey.currentState?.pushNamed("/");
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
