import 'package:agroxpress/src/pages/perfil/publication_card.dart';
import 'package:agroxpress/src/utils/styles.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:flutter/material.dart';

class MyPublicationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Mis publicaciones",
          style: TextStyle(
            fontWeight: kAppbarTitles,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        children: [
          Text("Mis publicaciones",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20.0)),
          sb(15.0),
          PublicationCard(),
          PublicationCard(),
          PublicationCard(),
          PublicationCard(),
        ],
      ),
    );
  }
}
