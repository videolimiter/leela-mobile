import 'package:flutter/material.dart';

class Leela extends ChangeNotifier {
  final double id;
  final double guideId;
  late List<Player> players;
  late String title;
  late String description;
  late String avatarImage;

  Leela({
    required this.id,
    required this.guideId,
    required this.players,
  });

  void removeAllPlayers() {
    players.clear();
    notifyListeners();
  }

  void addPlayer(Player player) {
    players.add(player);
    notifyListeners();
  }

  void updateLeela(Leela leela) {
    title = leela.title;
    description = leela.description;
    avatarImage = leela.avatarImage;
    notifyListeners();
  }

  void createLeela(Leela leela) {
    title = leela.title;
    description = leela.description;
    avatarImage = leela.avatarImage;
    notifyListeners();
  }
}

class Guide {
  final double id;
  late List<Leela> leelas;

  Guide({
    required this.id,
    required this.leelas,
  });

  void removeAllLeelas() {
    leelas.clear();
  }

  void addLeela(Leela leela) {
    leelas.add(leela);
  }
}

class Player {
  final double id;
  final String name;
  late String? avatarImage;
  final String role;
  late String? description;
  late int? cellId;

  Player({
    this.cellId,
    required this.id,
    required this.name,
    required this.role,
    this.description,
    this.avatarImage,
  });
}

enum CellTitleType { arrow, snake }

class CellTitle {
  final String title;
  final CellTitleType? type;
  final int? movesToCellId;

  CellTitle({required this.title, this.type, this.movesToCellId});
}

final leelaCellTitles = [
  CellTitle(title: "Janma"),
  CellTitle(title: "Maya"),
  CellTitle(title: "Krodha"),
  CellTitle(title: "Lobha"),
  CellTitle(title: "Bhu Loka"),
  CellTitle(title: "Moha"),
  CellTitle(title: "Mada"),
  CellTitle(title: "Matsara"),
  CellTitle(title: "Kama Loka"),
  CellTitle(title: "Tapa", type: CellTitleType.arrow, movesToCellId: 23),
  CellTitle(title: "Gandharva"),
  CellTitle(title: "Irasya", type: CellTitleType.snake, movesToCellId: 8),
  CellTitle(title: "Antariksha"),
  CellTitle(title: "Bhuvar Loka"),
  CellTitle(title: "Naga Loka"),
  CellTitle(title: "Dwesha", type: CellTitleType.snake, movesToCellId: 4),
  CellTitle(title: "Daya", type: CellTitleType.arrow, movesToCellId: 69),
  CellTitle(title: "Harsha Loka"),
  CellTitle(title: "Karma Loka"),
  CellTitle(title: "Dana", type: CellTitleType.arrow, movesToCellId: 32),
  CellTitle(title: "Saman Paap"),
  CellTitle(title: "Dharma", type: CellTitleType.arrow, movesToCellId: 60),
  CellTitle(title: "Swarga Loka"),
  CellTitle(title: "Ku Sang Loka", type: CellTitleType.snake, movesToCellId: 7),
  CellTitle(title: "Su Sang Loka"),
  CellTitle(title: "Dukha"),
  CellTitle(title: "Param Artha", type: CellTitleType.arrow, movesToCellId: 41),
  CellTitle(title: "Su-Dharma", type: CellTitleType.arrow, movesToCellId: 50),
  CellTitle(title: "A-Dharma", type: CellTitleType.snake, movesToCellId: 6),
  CellTitle(title: "Uttama Gati"),
  CellTitle(title: "Yaksha Loka"),
  CellTitle(title: "Mahar Loka"),
  CellTitle(title: "Gandha Loka"),
  CellTitle(title: "Rasa Loka"),
  CellTitle(title: "Naraka Loka"),
  CellTitle(title: "Swatccha"),
  CellTitle(title: "Jnyana", type: CellTitleType.arrow, movesToCellId: 66),
  CellTitle(title: "Prana Loka"),
  CellTitle(title: "Apana Loka"),
  CellTitle(title: "Vyana Loka"),
  CellTitle(title: "Jana Loka"),
  CellTitle(title: "Agni Loka"),
  CellTitle(title: "Manushya Janma"),
  CellTitle(title: "A-Vidya", type: CellTitleType.snake, movesToCellId: 9),
  CellTitle(title: "Su-Vidya", type: CellTitleType.arrow, movesToCellId: 67),
  CellTitle(title: "Viveka", type: CellTitleType.arrow, movesToCellId: 62),
  CellTitle(title: "Saraswati"),
  CellTitle(title: "Yamuna"),
  CellTitle(title: "Ganga"),
  CellTitle(title: "Tapa Loka"),
  CellTitle(title: "Prithvi"),
  CellTitle(title: "Himsa Loka", type: CellTitleType.snake, movesToCellId: 35),
  CellTitle(title: "Jala Loka"),
  CellTitle(title: "Bhakti", type: CellTitleType.arrow, movesToCellId: 68),
  CellTitle(title: "Ahamkara", type: CellTitleType.snake, movesToCellId: 3),
  CellTitle(title: "Omkara"),
  CellTitle(title: "Vayu Loka"),
  CellTitle(title: "Teja Loka"),
  CellTitle(title: "Satya Loka"),
  CellTitle(title: "Su-Budhi"),
  CellTitle(title: "Dur-Budhi"),
  CellTitle(title: "Sukha"),
  CellTitle(title: "Tamas", type: CellTitleType.snake, movesToCellId: 2),
  CellTitle(title: "Prakriti Loka"),
  CellTitle(title: "Uranta Loka"),
  CellTitle(title: "Ananda Loka"),
  CellTitle(title: "Rudra Loka"),
  CellTitle(title: "Vaikuntha Loka"),
  CellTitle(title: "Brahma Loka"),
  CellTitle(title: "Sattva Guna"),
  CellTitle(title: "Raja Guna"),
  CellTitle(title: "Tama Guna", type: CellTitleType.snake, movesToCellId: 51),
];
