getCellIndex(int index) {
  // Чередование направлений для рядов, начиная слева снизу
  int row = index ~/ 9; // Номер ряда
  int col = index % 9; // Номер колонки
  if (row % 2 == 0) {
    return 72 - (row * 9 + col); // Для четных рядов, начиная слева
  } else {
    return 72 - (row * 9 + (8 - col)); // Для нечетных рядов, начиная справа
  }
}
