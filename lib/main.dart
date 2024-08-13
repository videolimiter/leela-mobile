import 'package:flutter/material.dart';
import 'package:leela_mobile/pages/leelapage.dart';

/// Flutter code sample for [AppBar].

List<String> titles = <String>[
  'Cloud',
  'Beach',
  'Sunny',
];

void main() => runApp(const LeelaGameApp());

class LeelaGameApp extends StatelessWidget {
  const LeelaGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leela Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LeelaPage(),
    );
  }
}
