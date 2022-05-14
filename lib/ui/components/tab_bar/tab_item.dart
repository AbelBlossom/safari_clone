import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safari_clone/ui/common/constants.dart';
import 'package:safari_clone/ui/provider/ui_manager.dart';
import 'package:remaths/remaths.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.textformat_size,
                  size: 15,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.lock_fill,
                    size: 12,
                    color: Colors.grey[700],
                  ),
                  const Text("microsoft.com"),
                ],
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
          ),
        ),
      ),
    );
  }
}
