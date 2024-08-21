import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:leela_mobile/src/features/auth/screens/login/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(style: TextStyle(color: Colors.white), 'Welcome'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () => Navigator.pop(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      ),
                      child: const Text('Login'),
                    )),
                    const SizedBox(width: 10),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () => {}, child: const Text('SignUp'))),
                  ],
                )
              ],
            )));
  }
}
