import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safari_clone/ui/common/widgets/blur_widget.dart';

class PopMenu extends StatelessWidget {
  const PopMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlurFilter(
        child: Column(
          children: [
            ListTile(
              title: Text("yeah"),
            ),
          ],
        ),
      ),
    );
  }
}
