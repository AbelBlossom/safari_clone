import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:safari_clone/ui/components/tab_bar/tab_bar.dart';

class Browser extends StatefulWidget {
  const Browser({Key? key}) : super(key: key);

  @override
  State<Browser> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoScaffold(
        // transitionBackgroundColor: CupertinoColors.white,
        // topRadius: const Radius.circular(20),
        body: CupertinoPageScaffold(
          child: Stack(
            children: [
              Positioned.fill(
                child: ListView.builder(
                  itemCount: 200,
                  itemBuilder: (context, index) {
                    return Text(
                      "List $index of the list ",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: index % 2 == 0
                            ? CupertinoColors.systemRed
                            : CupertinoColors.systemBlue,
                      ),
                    );
                  },
                ),
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Tabbar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
