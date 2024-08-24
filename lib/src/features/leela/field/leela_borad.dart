import 'dart:async';

import 'package:flutter/material.dart';
import 'package:leela_mobile/src/core/helpers/getCellIndex.dart';
import 'package:leela_mobile/src/design/dimensions.dart';
import 'package:leela_mobile/src/features/leela/field/cell.dart';

class LeelaBoard extends StatefulWidget {
  final List<int> playerPositions;

  const LeelaBoard({super.key, required this.playerPositions});

  @override
  _LeelaBoardState createState() => _LeelaBoardState();
}

class _LeelaBoardState extends State<LeelaBoard> {
  List<int> _selectedCells = []; // Список выбранных ячеек

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // Получаем размеры экрана
    final cellSize = (screenSize.width / 9).clamp(
        0, screenSize.height / 8); // Размер клетки, чтобы поместилось 9 в ряд

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 9, // 9 клеток в ряд
        childAspectRatio: 1, // Соотношение сторон 1:1
      ),
      itemCount: 72,
      itemBuilder: (context, index) {
        return GestureDetector(
          // Добавляем GestureDetector для обработки нажатий
          onTap: () =>
              _toggleCellSelection(getCellIndex(index)), // Обработка нажатия
          child: Container(
            width: cellSize.toDouble(), // Устанавливаем ширину клетки
            height: cellSize.toDouble(), // Устанавливаем высоту клетки
            child: _buildCell(context, getCellIndex(index)),
          ),
        );
      },
    );
  }

  void _toggleCellSelection(int index) {
    final prevCells = List<int>.from(_selectedCells);

    setState(() {
      _selectedCells.clear();
      // Если индекс не содержится в предыдущем списке, добавляем его
      if (!prevCells.contains(index)) {
        _selectedCells.add(index);
      }
    });
  }

  Widget _buildCell(BuildContext context, int index) {
    return Cell(
      index: index,
      isSelected: _selectedCells.contains(index),
      isPlayerPosition: widget.playerPositions.contains(index),
      onTap: () => _toggleCellSelection((index)),
    );
  }
}
