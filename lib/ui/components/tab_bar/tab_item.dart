import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safari_clone/ui/common/constants.dart';
import 'package:safari_clone/provider/ui_manager.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/ui/common/widgets/pop_menu.dart';

// Update the search bar when the user is trying to enter some text
class TabItem extends StatelessWidget {
  const TabItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiManager = context.read<UIManager>();
    return AnimatedBuilder(
      animation: uiManager.offsetListener,
      builder: (_, child) {
        var offset = uiManager.swapListener.value.interpolate(
          [0.0, 1.0],
          [0.0, -200.0],
          Extrapolate.CLAMP,
        );
        //TODO: animate the tab items from the top when switch between overview

        // print("swap ${uiManager.swapListener.value}");
        return Transform.translate(
          offset: Offset.zero,
          child: child,
        );
      },
      child: const _TabItemContent(),
    );
  }
}

class _TabItemContent extends StatelessWidget {
  const _TabItemContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      height: CONSTANTS.TABITEM_HEIGHT,
      width: MediaQuery.of(context).size.width - CONSTANTS.TABITEM_OFFSET,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: const [
              Positioned(bottom: 0, left: 0, right: 0, child: ProgressBar()),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: TabContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: FractionallySizedBox(
        widthFactor: 0.2,
        child: Container(
          color: CupertinoTheme.of(context).primaryColor,
          height: 2,
          width: MediaQuery.of(context).size.width - CONSTANTS.TABITEM_OFFSET,
        ),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  const TabContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // CupertinoButton(
        //   padding: EdgeInsets.zero,
        //   child: const Icon(
        //     CupertinoIcons.textformat_size,
        //     size: 15,
        //     color: Colors.black,
        //   ),
        //   onPressed: () {},
        // ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: CustomPopupMenu(
            showArrow: false,
            barrierColor: Colors.transparent,
            position: PreferredPosition.top,
            verticalMargin: 20.0,
            horizontalMargin: CONSTANTS.TABITEM_OFFSET / 2,
            menuBuilder: () {
              return PopMenu(
                children: [
                  PopMenuItem(
                      title: "Show Top Address bar",
                      onTap: () {},
                      icon: CupertinoIcons.add),
                  PopMenuItem(
                      title: "Show Top Address bar",
                      // onTap: () {},
                      icon: CupertinoIcons.add),
                  const PopMenuDivider(),
                  PopMenuItem(
                    title: "Privacy Report",
                    subtitle: "1 Tracker Prevented",
                    onTap: () {},
                    icon: CupertinoIcons.square_line_vertical_square,
                  ),
                  PopMenuItem(
                      title: "WebSite Settings",
                      onTap: () {},
                      icon: CupertinoIcons.settings),
                  const PopMenuDivider(),
                  PopMenuItem(
                    title: "Share",
                    onTap: () {},
                    icon: CupertinoIcons.move,
                  )
                ],
              );
            },
            pressType: PressType.singleClick,
            child: const Icon(
              CupertinoIcons.textformat_size,
              size: 15,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              CupertinoIcons.lock_fill,
              size: 15,
              color: Colors.grey[700],
            ),
            const Text("https://url.com")
          ]),
        ),
        // create cupertino icon button
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.refresh_bold,
            size: 15,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}


// class NewTabContent extends StatefulWidget {
//   const NewTabContent({Key? key}) : super(key: key);

//   @override
//   State<NewTabContent> createState() => _NewTabContentState();
// }

// class _NewTabContentState extends State<NewTabContent> {
//   @override
//   Widget build(BuildContext context) {
//     return Row();
//   }
// }