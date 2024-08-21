import 'package:flutter/material.dart';
import 'package:leela_mobile/src/api/user.dart';
import 'package:leela_mobile/src/core/authenticated.dart';
import 'package:leela_mobile/src/features/auth/screens/login/login_screen.dart';
import 'package:leela_mobile/src/pages/leelapage.dart';
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
    final authProvider = Provider.of<IsAuth>(context);

    return StreamBuilder(
      stream: oneSecStream(const Duration(seconds: 1)),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (authProvider.isAuthenticated) {
          return const LeelaPage();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
