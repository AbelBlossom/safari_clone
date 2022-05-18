import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/ui/common/widgets/background.dart';
import 'package:safari_clone/provider/ui_manager.dart';

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
      animation:
          Listenable.merge([uiManager.offsetListener, uiManager.yListener]),
      builder: (_, child) {
        // print(uiManager.page);
        return Stack(
          children: [
            //TODO: Find a way to refresh this widget when the a new tab is created
            // suggested: pass a function from here to refresh
            // the widget to the uiManager
            ...uiManager.tabs
                .map((index) => index == uiManager.selectedPage
                    ? Container()
                    : TabViewBuilder(key: GlobalKey(), index: index))
                .toList(),

            TabViewBuilder(index: uiManager.selectedPage),
          ],
        );
      },
    );
  }
}

class TabViewBuilder extends StatelessWidget {
  final int index;
  const TabViewBuilder({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var uiManager = context.watch<UIManager>();
    var diff = uiManager.page - index;

    var scale =
        uiManager.yVal.interpolate([0.0, 1.0], [0.5, 1.0], Extrapolate.CLAMP);
    // var hr = uiManager.yVal
    // .interpolate([0.0, 1.0], [0.5, 1.0], Extrapolate.CLAMP);
    final radius =
        uiManager.yVal.interpolate([0.0, 1.0], [50.0, 0.0], Extrapolate.CLAMP);
    final to = -1 * (diff * size.width);
    return Positioned(
        top: 0,
        left: 0,
        child: Transform.scale(
          scale: scale.abs(),
          child: Transform.translate(
            offset: Offset(to, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Hero(
                tag: "tab_$index",
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 50),
                  width: size.width - radius,
                  height: size.height * scale,
                  color: index % 2 == 0
                      ? CupertinoColors.activeBlue
                      : CupertinoColors.activeGreen,
                  child: CupertinoButton(
                    onPressed: () {},
                    child: Text("TRY"),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
