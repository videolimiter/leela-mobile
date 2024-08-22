import 'package:flutter/material.dart';
import 'package:leela_mobile/src/core/authenticated.dart';
import 'package:leela_mobile/src/design/colors.dart';
import 'package:leela_mobile/src/design/dimensions.dart';
import 'package:leela_mobile/src/features/auth/screens/welcome/welcome_screen.dart';
import 'package:leela_mobile/src/features/leela/screens/leela_screen.dart';
import 'package:provider/provider.dart';

Stream oneSecStream(Duration refreshTime) async* {
  while (true) {
    await Future.delayed(refreshTime);
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<IsAuth>(context, listen: true);
    return Scaffold(
      appBar: authProvider.isAuthenticated
          ? AppBar(
              backgroundColor: sixthColor,
              elevation: 1,
              centerTitle: true,
              title: const Text(
                'Leela Game',
                style: TextStyle(
                  fontSize: fontHeadingSize,
                  fontWeight: FontWeight.bold,
                  color: thirdColor,
                ),
              ))
          : null,
      body: Container(
        color: sixthColor,
        child: StreamBuilder<bool>(
          stream: authProvider.authStream,
          initialData: authProvider.isAuthenticated,
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return const LeelaScreen();
            } else {
              return const WelcomeScreen();
            }
          },
        ),
      ),
      drawer: Drawer(
          child: ListView(children: [
        const DrawerHeader(child: Text('Меню')),
        ListTile(
            title: const Text("Logout"),
            onTap: () {
              authProvider.logout();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              // );
            })
      ])),
    );
  }
}
