import 'package:flutter/material.dart';
import 'package:leela_mobile/src/features/leela/field/leela_board.dart';
import 'package:leela_mobile/src/features/leela/model/leela.dart';

class LeelaScreen extends StatefulWidget {
  const LeelaScreen({super.key});

  @override
  _LeelaScreenState createState() => _LeelaScreenState();
}

class _LeelaScreenState extends State<LeelaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Player> players = [
    Player(id: 1, name: 'Player 1', role: 'Player'),
    Player(id: 2, name: 'Player 2', role: 'Player', cellId: 3),
    Player(id: 3, name: 'Player 3', role: 'Player'),
    Player(id: 4, name: 'Player 4', role: 'Player', cellId: 5),
    Player(id: 5, name: 'Player 5', role: 'Player', cellId: 66),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Игровое поле игры',
            style: TextStyle(fontSize: kDefaultFontSize),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
              child: LeelaBoard(
            players: players,
          )),
          const Center(child: Text('История')),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: 'Игра'),
          Tab(text: 'История'),
        ],
      ),
    );
  }
}
