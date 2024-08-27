import 'package:flutter/material.dart';

Color getGradientColor(int index) {
  const List<Color> colors = [
    Colors.blue,
    Colors.cyan,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.pink,
  ];
  int colorCount = colors.length;
  double position = index / 71 * (colorCount - 1);
  int lowerIndex = position.floor();
  int upperIndex = lowerIndex + 1;

  if (upperIndex >= colorCount) return colors.last;

  double t = position - lowerIndex;
  return Color.lerp(colors[lowerIndex], colors[upperIndex], t)!;
}
