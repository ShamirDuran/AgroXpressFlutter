import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:flutter/material.dart';

final String kFontFamilyJos = "JosefinSans";

Widget sb(double height) {
  return SizedBox(height: height);
}

// Show simple snackbar
void showSnackBar(String msg, GlobalKey<ScaffoldState> key) {
  final snack = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(msg),
    duration: Duration(milliseconds: 3200),
  );
  ScaffoldMessenger.of(key.currentContext).showSnackBar(snack);
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
        TextButton(
          child: Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Ok"),
          onPressed: () {
            // TODO: Borrar esto si se cambia logica por traer desde backend
            userPref.token = "";
            userPref.name = "";
            userPref.surname = "";
            userPref.image = "";
            Navigator.pushNamedAndRemoveUntil(context, "login", (r) => false);
          },
        ),
      ],
    ),
  );
}
