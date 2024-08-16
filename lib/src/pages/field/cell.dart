import 'package:flutter/material.dart';
import 'package:leela_mobile/src/design/colors.dart';

class Cell extends StatelessWidget {
  const Cell({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        child: InkWell(
            onTap: () => {},
            child: Container(
                color: secondaryColor,
                height: 25,
                width: 25,
                child: Center(
                    child: Text(
                        style: const TextStyle(color: thirdColor), text)))));
  }
}
