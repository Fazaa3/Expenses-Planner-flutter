import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class Chartbar extends StatelessWidget {
  final String label;
  final double spendingamount;
  final double spendingpcd;

  // ignore: use_key_in_widget_constructors
  Chartbar(this.label, this.spendingamount, this.spendingpcd);

  @override
  Widget build(BuildContext context) {
    Color getColor(double value) {
       if (value <= 0.2) {
    return Color(0xFFA1887F); // Light brown
  } else if (value <= 0.5) {
    return Color(0xFF795548); // Medium brown
  } else if (value <= 0.8) {
    return Color(0xFF5D4037); // Dark brown
  } else {
    return Color(0xFF3E2723); // Very dark brown
  }
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Container(
                height: 20,
                child: FittedBox(
                    child: Text('D${spendingamount.toStringAsFixed(0)}'))),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 70,
              width: 24,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(8)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: spendingpcd,
                    widthFactor: 1,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: getColor(spendingpcd),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 4,
            ),
            Text(label),
          ],
        );
      },
    );
  }
}
