import 'package:flutter/material.dart';
import 'package:leela_mobile/src/api/user.dart';
import 'package:leela_mobile/src/design/colors.dart';
import 'package:leela_mobile/src/design/dimensions.dart';
import 'package:leela_mobile/src/features/auth/screens/welcome/welcome_screen.dart';
import 'package:leela_mobile/src/pages/field/leela_field.dart';

class LeelaPage extends StatelessWidget {
  const LeelaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          )),
      body: Container(
        color: sixthColor,
        child: const Align(alignment: Alignment.center, child: LeelaField()),
      ),
      drawer: Drawer(
          child: ListView(children: [
        const DrawerHeader(child: Text('Меню')),
        ListTile(
            title: const Text("Logout"),
            onTap: () {
              logoutUser();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            })
      ])),
    );
  }
}
