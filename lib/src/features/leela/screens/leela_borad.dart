import 'dart:async';

import 'package:flutter/material.dart';
import 'package:leela_mobile/src/design/dimensions.dart';

class LeelaBoard extends StatefulWidget {
  final List<int> playerPositions;

  const LeelaBoard({super.key, required this.playerPositions});

  @override
  _LeelaBoardState createState() => _LeelaBoardState();
}

class _LeelaBoardState extends State<LeelaBoard> {
  Color _currentColor = Colors.red;
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
              _toggleCellSelection(_getCellIndex(index)), // Обработка нажатия
          child: Container(
            width: cellSize.toDouble(), // Устанавливаем ширину клетки
            height: cellSize.toDouble(), // Устанавливаем высоту клетки
            child: _buildCell(context, _getCellIndex(index)),
          ),
        );
      },
    );
  }

  int _getCellIndex(int index) {
    // Чередование направлений для рядов, начиная слева снизу
    int row = index ~/ 9; // Номер ряда
    int col = index % 9; // Номер колонки
    if (row % 2 == 0) {
      return 72 - (row * 9 + col); // Для четных рядов, начиная слева
    } else {
      return 72 - (row * 9 + (8 - col)); // Для нечетных рядов, начиная справа
    }
  }

  void _toggleCellSelection(int index) {
    setState(() {
      if (_selectedCells.contains(index)) {
        _selectedCells.remove(index); // Убираем из выбранных
      } else {
        _selectedCells.add(index); // Добавляем в выбранные
      }
    });
  }

  Widget _buildCell(BuildContext context, int index) {
    Color cellColor;
    Border border;

    if (_selectedCells.contains(index)) {
      // Проверяем на выбранность
      cellColor = Colors.blue; // Цвет для выбранной клетки
    } else if (widget.playerPositions.contains(index)) {
      cellColor = Colors.green; // Цвет для клетки игрока
      border = Border.all(
        color: Colors.red,
        width: 1,
        style: BorderStyle.solid,
      );
    } else {
      cellColor = Colors.white; // Цвет для пустой клетки
      border = Border.all(
        color: Colors.black,
        width: 1,
        style: BorderStyle.solid,
      );
    }

    // Добавляем анимацию цвета
    return AnimatedContainer(
      duration: const Duration(seconds: 1), // Длительность анимации
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: cellColor, // Используем cellColor для фона
        borderRadius: BorderRadius.circular(borderRadiusDefault / 2),
        border: Border.all(), // Используем border для границы
      ),
      child: Center(
        child: Text(
          '${index}', // Номер клетки
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
