import 'package:flutter/cupertino.dart';
import 'package:remaths/remaths.dart';
import 'package:safari_clone/provider/ui_manager.dart';
import 'package:provider/provider.dart';

class OverViewBar extends StatelessWidget {
  const OverViewBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiManger = context.read<UIManager>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          CupertinoButton(
            padding: const EdgeInsets.all(10.0),
            child: const Icon(CupertinoIcons.add),
            onPressed: () {
              uiManger.createNewTab();
              uiManger.gotoPage(uiManger.tabSize);
              uiManger.setY(1);
              uiManger.setSwap(0);
              uiManger.navigatorKey.currentState!.pop();
            },
          ),
          Expanded(child: Center(child: Text("${uiManger.tabSize + 1} Tabs"))),
          CupertinoButton(
            padding: const EdgeInsets.all(10.0),
            child: const Text("Done"),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
