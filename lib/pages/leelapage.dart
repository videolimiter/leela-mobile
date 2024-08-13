import 'package:flutter/material.dart';
import 'package:leela_mobile/design/colors.dart';
import 'package:leela_mobile/design/dimensions.dart';
import 'package:leela_mobile/pages/field/cell.dart';
import 'package:leela_mobile/pages/field/leela_field.dart';

class LeelaPage extends StatelessWidget {
  const LeelaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
    );
  }
}
