import 'package:flutter/cupertino.dart';

class NewTab extends StatelessWidget {
  const NewTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: Center(
        child: Text("New Tab"),
      ),
    );
  }
}
