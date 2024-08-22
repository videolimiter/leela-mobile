import 'package:flutter/material.dart';
import 'package:leela_mobile/src/api/user.dart';
import 'package:leela_mobile/src/core/authenticated.dart';
import 'package:leela_mobile/src/features/auth/screens/auth_wrapper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => IsAuth())],
      child: const LeelaGameApp()));
}

class LeelaGameApp extends StatelessWidget {
  const LeelaGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leela Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: FutureBuilder<bool?>(
        future: Provider.of<IsAuth>(context, listen: false).checkCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return const AuthWrapper();
          }
        },
      ),
    );
  }
}
