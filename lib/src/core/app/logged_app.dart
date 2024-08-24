import 'package:flutter/material.dart';
import 'package:leela_mobile/src/core/app/app_drawer.dart';
import 'package:leela_mobile/src/features/dashboard/screens/dashboard_screen.dart';
import 'package:leela_mobile/src/features/leela/screens/leela_borad.dart';

class LoggedApp extends StatelessWidget {
  const LoggedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Leela',
      home: MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  String _appBarTitle = 'Главная';
  late Widget _currentBody;
  String _currentRoute = '/';

  @override
  void initState() {
    super.initState();
    _currentBody = const LeelaBoard(playerPositions: [3, 4, 5, 7, 8, 40, 9]);
  }

  void _navigateTo(String route) {
    setState(() {
      _currentRoute = route;
      switch (route) {
        case '/':
          _appBarTitle = 'Главная';
          _currentBody =
              const LeelaBoard(playerPositions: [3, 4, 5, 7, 8, 40, 9]);
          break;
        case '/profile':
          _appBarTitle = 'Профиль';
          _currentBody = const ProfileScreen();
          break;
        case '/user/games':
          _appBarTitle = 'Мои игры';
          _currentBody = const MyGamesScreen();
          break;
        default:
          _appBarTitle = 'Главная';
          _currentBody =
              const LeelaBoard(playerPositions: [3, 4, 5, 7, 8, 40, 9]);
      }
    });
    Navigator.of(context).pop(); // Закрываем Drawer после навигации
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: _currentBody,
      drawer: AppDrawer(
        currentRoute: _currentRoute, // Передаем текущий маршрут в AppDrawer
        onNavigate: _navigateTo, // Передаем функцию навигации
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: LeelaBoard(playerPositions: [3, 4, 5, 7, 8, 40, 9]));
  }
}

class MyGamesScreen extends StatelessWidget {
  const MyGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Игры пользователя'));
  }
}
