import 'package:flutter/material.dart';
import 'package:leela_mobile/src/features/leela/model/leela.dart';

class Cell extends StatefulWidget {
  final int index;
  final bool isSelected;
  final bool isPlayerPosition;
  final List<Player> players;
  final Function onTap;

  const Cell({
    super.key,
    required this.index,
    required this.isSelected,
    required this.isPlayerPosition,
    required this.players,
    required this.onTap,
  });

  @override
  _CellState createState() => _CellState();
}

class _CellState extends State<Cell> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color cellColor;
    Border border =
        Border.all(color: const Color.fromARGB(120, 0, 0, 0), width: 2);

    if (widget.isSelected) {
      cellColor = Colors.blue;
      border = Border.all(color: Colors.purple, width: 3);
    } else if (widget.isPlayerPosition) {
      cellColor = Colors.green;
      border = Border.all(color: Colors.red, width: 1);
    } else {
      cellColor = Colors.transparent;
      border = Border.all(color: Colors.transparent, width: 1);
    }

    if (_isHovered) {
      cellColor = Colors.yellow;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => widget.onTap(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          // margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: cellColor,
            // borderRadius: BorderRadius.circular(8),
            // border: border,
          ),
          child: Center(
            child: Text(
              '${widget.index}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
