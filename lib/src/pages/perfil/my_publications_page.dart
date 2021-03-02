import 'package:agroxpress/src/models/publication_model.dart';
import 'package:agroxpress/src/pages/perfil/publication_card.dart';
import 'package:agroxpress/src/providers/publications_provider.dart';
import 'package:agroxpress/src/utils/styles.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:flutter/material.dart';

class MyPublicationsPage extends StatelessWidget {
  final _publicationsProvider = PublicationsProvider();

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
      body: FutureBuilder(
        future: _publicationsProvider.getUserPublications(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PublicationModel>> snapshot) {
          if (snapshot.hasData) {
            return _buildBody(context, snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<PublicationModel> data) {
    return data.isEmpty
        ? Center(
            child: TextButton(
                child: Text(
                  "Crea tu primera publicación!",
                  style: TextStyle(fontSize: 16.0),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.popAndPushNamed(context, "create-publication");
                }),
          )
        : Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                sb(20.0),
                Text("Mis publicaciones",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 20.0)),
                sb(15.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PublicationCard(data[index]);
                  },
                ),
              ],
            ),
          );
  }
}
