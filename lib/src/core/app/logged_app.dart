import 'package:flutter/material.dart';
import 'package:leela_mobile/src/core/authenticated.dart';
import 'package:leela_mobile/src/features/dashboard/screens/dashboard_screen.dart';
import 'package:provider/provider.dart';

class LoggedApp extends StatelessWidget {
  const LoggedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leela',
      home: const MainLayout(),
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
  Widget _currentBody = GridDashboard();

  void _navigateTo(String route) {
    setState(() {
      switch (route) {
        case '/':
          _appBarTitle = 'Главная';
          _currentBody = GridDashboard();
          break;
        case '/profile':
          _appBarTitle = 'Профиль';
          _currentBody = const ProfileScreen();
          break;
        default:
          _appBarTitle = 'Главная';
          _currentBody = GridDashboard();
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
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Меню')),
            ListTile(
              title: const Text("Главная"),
              onTap: () => _navigateTo('/'),
            ),
            ListTile(
              title: const Text("Профиль"),
              onTap: () => _navigateTo('/profile'),
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () {
                Provider.of<IsAuth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Профиль пользователя'));
  }
}
