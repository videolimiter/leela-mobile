import 'package:flutter/material.dart';
import 'package:leela_mobile/src/core/authenticated.dart';
import 'package:leela_mobile/src/design/colors.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;
  final Function(String) onNavigate;

  const AppDrawer(
      {super.key, required this.currentRoute, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(
              height: 80,
              child: DrawerHeader(
                decoration: BoxDecoration(color: fourthColor),
                child: Text('Меню'),
              )),
          ListTile(
            title: const Text("Главная"),
            selected: currentRoute == '/',
            onTap: () => onNavigate('/'),
          ),
          ListTile(
            title: const Text("Профиль"),
            selected: currentRoute == '/profile',
            onTap: () => onNavigate('/profile'),
          ),
          ListTile(
            title: const Text("Мои игры"),
            selected: currentRoute == '/user/games',
            onTap: () => onNavigate('/user/games'),
          ),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              Provider.of<IsAuth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
