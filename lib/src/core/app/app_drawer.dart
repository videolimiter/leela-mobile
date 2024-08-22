import 'package:flutter/material.dart';
import 'package:leela_mobile/src/core/authenticated.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Text('Меню')),
          ListTile(
            title: const Text("Главная"),
            onTap: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          ListTile(
            title: const Text("Профиль"),
            onTap: () {
              Navigator.of(context).pushNamed('/profile');
            },
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
