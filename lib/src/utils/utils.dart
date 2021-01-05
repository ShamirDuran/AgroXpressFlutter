import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:flutter/material.dart';

final String kFontFamilyJos = "JosefinSans";

Widget sb(double height) {
  return SizedBox(height: height);
}

// Show simple snackbar
void showSnackBar(String msg, GlobalKey<ScaffoldState> key) {
  final snack = SnackBar(
    content: Text(msg),
    duration: Duration(milliseconds: 3000),
  );

  key.currentState.showSnackBar(snack);
}

// Log out account dialog
void showLogOutDialog(BuildContext context, UserPref userPref) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: Text("Cerrar sesión"),
      content: Text("¿Desea cerrar su sesión?"),
      actions: [
        FlatButton(
          child: Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Ok"),
          onPressed: () {
            userPref.token = "";
            Navigator.pushReplacementNamed(context, "login");
          },
        ),
      ],
    ),
  );
}
