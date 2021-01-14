import 'package:agroxpress/src/utils/styles.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Notificaciones",
          style: TextStyle(fontWeight: kAppbarTitles),
        ),
      ),
      body: data.isEmpty
          ? Center(child: Text("No tienes notificaciones"))
          // TODO: Agregar vista de notificaciones
          : Text("hola"),
    );
  }
}
