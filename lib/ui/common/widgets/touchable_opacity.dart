import 'package:flutter/cupertino.dart';

class TouchableOpacity extends StatefulWidget {
  final Widget child;
  final void Function()? onTap;
  final Duration duration;
  final double opacity;

  const TouchableOpacity({
    Key? key,
    required this.child,
    this.onTap,
    this.opacity = 0.5,
    this.duration = const Duration(milliseconds: 50),
  }) : super(key: key);

  @override
  createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity> {
  bool isDown = false;

  @override
  void initState() {
    super.initState();
    // setState(() => isDown = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isDown = true),
      onTapUp: (_) => setState(() => isDown = false),
      onTapCancel: () => setState(() => isDown = false),
      onTap: widget.onTap,
      child: AnimatedOpacity(
        duration: widget.duration,
        opacity: isDown ? widget.opacity : 1,
        child: widget.child,
      ),
    );
  }
}
