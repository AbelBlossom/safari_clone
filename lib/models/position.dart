class Position {
  double scale;
  double x;
  double y;
  double radius;
  double height;
  double width;

  double prevY = 0;

  Position({
    this.scale = 1.0,
    this.x = 0.0,
    this.y = 0.0,
    this.radius = 0.0,
    this.height = 0.0,
    this.width = 0.0,
  });

  @override
  String toString() {
    return "(x: $x) (scale: $scale) (y: $y) (radius: $radius) (height: $height) (width: $width)";
  }

  static getLine(int index) {
    return (((index % 2 == 0 ? index + 1 : index) + 1) / 2) - 1;
  }
}
