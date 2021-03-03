import 'package:agroxpress/src/models/publication_model.dart';
import 'package:agroxpress/src/providers/publications_provider.dart';
import 'package:agroxpress/src/search/search_card.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  String select = "";
  final _publicationsProvider = PublicationsProvider();
  final publications = [];
  final _listController = ScrollController();

  @override
  void close(BuildContext context, result) {
    _listController.dispose();
    super.close(context, result);
  }

  @override
  String get searchFieldLabel => "Buscar publicaciones";

  @override
  List<Widget> buildActions(BuildContext context) {
    // Contiene la acciones del Appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
      // IconButton(
      //   icon: Icon(Icons.filter_list),
      //   onPressed: () {},
      // )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icon a la izquierda del Appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que se van a mostrar
    return Center(
      child: _listResults(context),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Muestra los resultados a medida que se va a escribiendo
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: _publicationsProvider.getSearch(query),
      builder: (BuildContext context,
          AsyncSnapshot<List<PublicationModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isEmpty)
            return Center(child: Text("No se encontraron publicaciones"));
          publications.clear();
          publications.addAll(snapshot.data);
          return _listResults(context);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _listResults(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      itemCount: publications.length,
      itemBuilder: (BuildContext context, int index) {
        return SearchCard(publications[index]);
      },
    );
  }
}
