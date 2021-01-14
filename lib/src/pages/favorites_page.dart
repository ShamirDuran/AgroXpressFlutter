import 'package:agroxpress/src/utils/styles.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  // Traer favoritos desde el backend
  final data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Favoritos",
          style: TextStyle(fontWeight: kAppbarTitles),
        ),
      ),
      body: data.isEmpty
          ? Center(
              child: Text("Aun no tienes favoritos"),
            )
          : Text("vacio"),
    );
  }
}
