import 'package:flutter/material.dart';
import 'package:leela_mobile/src/features/leela/field/cell.dart';

class LeelaField extends StatelessWidget {
  const LeelaField({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    for (var i = 72; i > 0; i--) {
      items.add(Cell(text: i.toString()));
    }
    var width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).size.width >
        MediaQuery.of(context).size.height) {
      width = MediaQuery.of(context).size.height;
    }
    ;

    return Container(
        width: width,
        child: GridView.count(
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          crossAxisCount: 9,
          children: items,
        ));
  }
}
