import 'package:flutter/material.dart';

class TitleExpanded extends StatelessWidget {
  final String title;
  final double padTop, padBottom;

  TitleExpanded({
    @required this.title,
    @required this.padTop,
    @required this.padBottom,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        top: size.height * this.padTop,
        bottom: size.height * this.padBottom,
      ),
      child: Center(
        child: Text(
          this.title,
          style: TextStyle(
            fontFamily: "Pacifico",
            color: Colors.white,
            fontSize: 60.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
