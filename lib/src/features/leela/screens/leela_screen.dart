import 'package:flutter/material.dart';
import 'package:leela_mobile/src/core/authenticated.dart';
import 'package:leela_mobile/src/design/colors.dart';
import 'package:leela_mobile/src/features/leela/field/leela_field.dart';
import 'package:provider/provider.dart';

class LeelaScreen extends StatelessWidget {
  const LeelaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<IsAuth>(builder: (context, auth, child) {
      return Container(
        color: sixthColor,
        child: const Align(alignment: Alignment.center, child: LeelaField()),
      );
    });
  }
}
