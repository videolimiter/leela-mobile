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
