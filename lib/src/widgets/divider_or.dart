import 'package:agroxpress/src/utils/utils.dart';
import 'package:flutter/material.dart';

import 'divider_expanded.dart';

class DividerOr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          DividerExpanded(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "ó",
              style: TextStyle(
                color: Colors.white,
                fontFamily: kFontFamilyJos,
                fontSize: 24.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          DividerExpanded(),
        ],
      ),
    );
  }
}
