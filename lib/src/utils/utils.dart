import 'package:agroxpress/src/models/publications_model.dart';
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

String getUnit(PublicationModel publication) {
  if (publication.measurementUnit.length < 4)
    return publication.measurementUnit;

  final temp = publication.measurementUnit.split(" ")[1];

  return temp.substring(1, temp.length - 1);
}
