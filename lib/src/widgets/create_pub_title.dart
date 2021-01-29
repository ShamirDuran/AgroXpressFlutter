import 'package:flutter/material.dart';

class CreatePubTitle extends StatelessWidget {
  final String title;

  CreatePubTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
        bottom: 0.0,
      ),
      width: double.infinity,
      child: Text(
        this.title,
        textAlign: TextAlign.center,
        overflow: TextOverflow.visible,
        style: TextStyle(
          color: Colors.black,
          fontSize: 23.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
