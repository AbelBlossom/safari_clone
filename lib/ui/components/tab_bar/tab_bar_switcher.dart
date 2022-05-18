import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:safari_clone/ui/common/constants.dart';
import 'package:safari_clone/ui/common/widgets/blur_widget.dart';
import 'package:safari_clone/ui/components/tab_bar/overview_bar.dart';
import 'package:safari_clone/ui/components/tab_bar/tab_bar.dart';
import 'package:safari_clone/provider/ui_manager.dart';
import 'package:remaths/remaths.dart';

class TabBarSwitcher extends StatelessWidget {
  const TabBarSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiManager = context.read<UIManager>();
    return SizedBox(
      height: CONSTANTS.TABBAR_HEIGHT,
      child: AnimatedBuilder(
          animation: uiManager.swapListener,
          builder: (context, child) {
            var tbo = uiManager.swapListener.value.interpolate(
              [0.0, 1.0],
              [0.0, CONSTANTS.TABBAR_HEIGHT],
            );
            var tof = uiManager.swapListener.value.interpolate(
              [0.5, 1.0],
              [50.0, 0.0],
            );
            return Stack(
              children: [
                Positioned.fill(
                  child: Transform.translate(
                    offset: Offset(0, tbo),
                    child: const Tabbar(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Transform.translate(
                    offset: Offset(0, tof),
                    child: ClipRRect(
                      child: Container(
                        height: 50,
                        color: CONSTANTS.LIGHT_BLUR_COLOR,
                        child: const Center(
                          child: BlurFilter(
                            child: OverViewBar(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
