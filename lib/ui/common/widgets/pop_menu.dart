import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safari_clone/ui/common/widgets/blur_widget.dart';
import 'package:safari_clone/ui/common/widgets/touchable_opacity.dart';

class PopMenu extends StatelessWidget {
  final List<Widget> children;
  const PopMenu({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: size.width * 0.6,
        color: Colors.white.withOpacity(0.5),
        child: BlurFilter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //for loop to create the menu items
              for (var i = 0; i < children.length; i++) ...[
                children[i],
                if (i != children.length - 1) const SizedBox(height: 1),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class PopMenuItem extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final IconData icon;
  final String? subtitle;
  // create the constructor
  const PopMenuItem(
      {Key? key,
      required this.title,
      this.onTap,
      required this.icon,
      this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    final color = disabled ? Colors.grey : Colors.black;
    return TouchableOpacity(
      onTap: onTap,
      opacity: disabled ? 1.0 : 0.0,
      child: Container(
        color: Colors.white.withOpacity(0.7),
        // height: 40,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: color,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        "$subtitle",
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: CupertinoColors.inactiveGray,
                        ),
                      )
                  ],
                ),
              ),
              Icon(
                icon,
                color: color,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopMenuDivider extends StatelessWidget {
  const PopMenuDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 5,
    );
  }
}
