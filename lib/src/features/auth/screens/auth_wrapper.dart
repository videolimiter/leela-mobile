import 'package:flutter/material.dart';
import 'package:leela_mobile/src/core/authenticated.dart';
import 'package:leela_mobile/src/features/auth/screens/welcome/welcome_screen.dart';
import 'package:leela_mobile/src/features/leela/screens/leela_screen.dart';
import 'package:leela_mobile/src/core/app/logged_app.dart';
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
    final authProvider = Provider.of<IsAuth>(context, listen: false);
    return StreamBuilder<bool>(
      stream: authProvider.authStream,
      initialData: authProvider.isAuthenticated,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return const LoggedApp();
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}
