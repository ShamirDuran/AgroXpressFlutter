import 'package:agroxpress/src/utils/styles.dart';
import 'package:flutter/material.dart';

class ShoppingPage extends StatelessWidget {
  // Cargar historial de compras desde el backend
  final data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Mis compras",
          style: TextStyle(fontWeight: kAppbarTitles),
        ),
      ),
      body: data.isEmpty
          ? Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  "Aqui puedes ver el historial de las compras que has realizado",
                ),
              ),
            )
          : Text("compras"),
    );
  }
}
