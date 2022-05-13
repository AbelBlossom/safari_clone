import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:safari_clone/ui/provider/ui_manager.dart';

class TabsOverview extends StatefulWidget {
  final void Function(int page) goTO;
  const TabsOverview({Key? key, required this.goTO}) : super(key: key);

  @override
  State<TabsOverview> createState() => _TabsOverviewState();
}

class _TabsOverviewState extends State<TabsOverview> {
  int? _i;

  @override
  Widget build(BuildContext context) {
    var uiManager = context.read<UIManager>();
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: uiManager.tabs.map((index) {
        return Hero(
          //  [index].contains(uiManager.selectedPage)
          // ? "tab_$index"
          // : "$index"
          tag: "tab_$index",
          child: Opacity(
            opacity: _i == null
                ? 1
                : _i == index
                    ? 1
                    : 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _i = index;
                });
                widget.goTO(index);
                // Future.delayed(const Duration(milliseconds: 3000), () {
                uiManager.navigatorKey.currentState?.pushNamed("/");
                // });
              },
              child: Container(
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
