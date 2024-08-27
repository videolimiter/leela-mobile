import 'package:flutter/material.dart';
import 'package:leela_mobile/src/core/helpers/getCellIndex.dart';
import 'package:leela_mobile/src/features/leela/field/back_image.dart';
import 'package:leela_mobile/src/features/leela/field/cell.dart';
import 'package:leela_mobile/src/features/leela/model/leela.dart';

class LeelaBoard extends StatefulWidget {
  final List<Player> players;

  LeelaBoard({super.key, required this.players});

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenSize = constraints.biggest; // Получаем размеры экрана
        final cellSize = (screenSize.width / 9).clamp(0,
            screenSize.height / 8); // Размер клетки, чтобы поместилось 9 в ряд
        return Center(
          // Добавлено Center
          child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                  // Используем Container для ограничения размеров
                  constraints: const BoxConstraints(
                    maxWidth:
                        double.infinity, // Максимальная ширина не ограничена
                    maxHeight:
                        double.infinity, // Максимальная высота не ограничена
                  ),
                  child: Stack(
                    children: [
                      // Используем Positioned.fill для изображения
                      Center(
                          child: Stack(children: [
                        Image.asset('assets/images/field_en.jpeg',
                            fit: BoxFit.cover),
                        Positioned(
                          top: 46,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Transform.scale(
                            scaleX:
                                0.927, // Вы можете изменить масштаб по своему усмотрению
                            scaleY: 0.94,
                            child: GridView.builder(
                              physics:
                                  const AlwaysScrollableScrollPhysics(), // Добавлено для прокрутки
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 9, // 9 клеток в ряд
                              ),
                              itemCount: 72,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  // Добавляем GestureDetector для обработки нажатий
                                  onTap: () => _toggleCellSelection(
                                      getCellIndex(index)), // Обработка нажатия
                                  child:
                                      _buildCell(context, getCellIndex(index)),
                                );
                              },
                            ),
                          ),
                        ),
                      ]))
                    ],
                  ))),
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
      players:
          widget.players.where((player) => player.cellId == index).toList(),
      isPlayerPosition: widget.players.any((player) => player.cellId == index),
      onTap: () => _toggleCellSelection((index)),
    );
  }
}
