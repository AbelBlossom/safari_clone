import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safari_clone/provider/ui_manager.dart';
import 'package:remaths/remaths.dart';

class BrowserBackground extends StatefulWidget {
  const BrowserBackground({Key? key}) : super(key: key);

  @override
  State<BrowserBackground> createState() => _BrowserBackgroundState();
}

class _BrowserBackgroundState extends State<BrowserBackground> {
  @override
  Widget build(BuildContext context) {
    final uiManager = context.read<UIManager>();
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: uiManager.yListener,
            builder: (context, child) {
              var scale = uiManager.yVal
                  .interpolate([0.0, 1.0], [1.8, 1.0], Extrapolate.CLAMP);
              return Transform.scale(scale: scale, child: child!);
            },
            child: Transform.scale(
              scale: 1.5,
              child: Image.asset("assets/bg.jpg"),
            ),
          ),
        ),
        Positioned(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                color: Colors.transparent,
              )),
        )
      ],
    );
  }
}
