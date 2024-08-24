import 'package:flutter/material.dart';
import 'package:leela_mobile/src/features/leela/field/leela_borad.dart';

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
        children: const [
          Center(child: LeelaBoard(playerPositions: [3, 4, 5, 7, 8, 40, 9])),
          Center(child: Text('История')),
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
