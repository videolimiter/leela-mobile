import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  final int index;
  final bool isSelected;
  final bool isPlayerPosition;
  final Function onTap;

  const Cell({
    super.key,
    required this.index,
    required this.isSelected,
    required this.isPlayerPosition,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color cellColor;
    Border border = Border.all(color: Colors.black, width: 2);

    if (isSelected) {
      cellColor = Colors.blue;
      border = Border.all(color: Colors.purple, width: 3);
    } else if (isPlayerPosition) {
      cellColor = Colors.green;
      border = Border.all(color: Colors.red, width: 1);
    } else {
      cellColor = Colors.white;
      border = Border.all(color: Colors.black, width: 1);
    }

    return GestureDetector(
      onTap: () => onTap(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: cellColor,
          borderRadius: BorderRadius.circular(8),
          border: border,
        ),
        child: Center(
          child: Text(
            '$index',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
