import 'package:flutter/material.dart';

Widget sb(double height) {
  return SizedBox(height: height);
}

void showSnackBar(String msg, GlobalKey<ScaffoldState> key) {
  final snack = SnackBar(
    content: Text(msg),
    duration: Duration(milliseconds: 3000),
  );

  key.currentState.showSnackBar(snack);
}
