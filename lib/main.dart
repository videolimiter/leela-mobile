import 'package:flutter/material.dart';
import 'package:leela_mobile/src/api/user.dart';
import 'package:leela_mobile/src/features/auth/screens/welcome/welcome_screen.dart';
import 'package:leela_mobile/src/pages/field/leela_field.dart';
import 'package:leela_mobile/src/pages/leelapage.dart';

void main() {
  runApp(const LeelaGameApp());
}

class LeelaGameApp extends StatelessWidget {
  const LeelaGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leela Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: FutureBuilder<bool>(
        future: getUser(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData && snapshot.data != false) {
            // Если ответ положительный, показываем первый экран
            return const LeelaPage();
          } else {
            // Если ответ отрицательный, показываем второй экран
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
