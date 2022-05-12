import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Test'),
      ),
      child: CupertinoScaffold(
          transitionBackgroundColor: CupertinoColors.white,
          body: Center(
            child: CupertinoButton(
              onPressed: () {
                showCupertinoModalBottomSheet(
                  expand: true,
                  context: context,
                  builder: (context) => TestPage(),
                );
              },
              child: Text("Open"),
            ),
          )),
    );
  }
}
