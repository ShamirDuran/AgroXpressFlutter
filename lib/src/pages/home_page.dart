import 'package:agroxpress/src/models/publication_model.dart';
import 'package:agroxpress/src/providers/publications_provider.dart';
import 'package:agroxpress/src/search/search_delegate.dart';
import 'package:agroxpress/src/widgets/carousel.dart';
import 'package:agroxpress/src/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _publicationsProvider = new PublicationsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      drawer: DrawerMenu(),
      body: _bodyHome(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      // Left icon
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      // Right icons
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart_outlined),
          onPressed: () {},
        )
      ],
      title: _searchAppBar(),
      centerTitle: true,
    );
  }

  Widget _searchAppBar() {
    final searchWidget = Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          Icon(Icons.search_outlined, color: Colors.grey[400]),
          SizedBox(width: 5.0),
          Text(
            "Buscar productos",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      // Search delegate action
      onTap: () => showSearch(context: context, delegate: DataSearch()),
      child: searchWidget,
    );
  }

  Widget _bodyHome() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: ListView(
        children: [
          FutureBuilder(
            future: _publicationsProvider.getAllPublications(),
            builder: (context, AsyncSnapshot<List<PublicationModel>> snapshot) {
              if (snapshot.hasData)
                return Carousel(snapshot.data, _scaffoldKey, "Oferta", "home");
              else
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 70.0),
                    child: CircularProgressIndicator(),
                  ),
                );
            },
          ),
          FutureBuilder(
            future: _publicationsProvider.getAllPublications(),
            builder: (context, AsyncSnapshot<List<PublicationModel>> snapshot) {
              if (snapshot.hasData)
                return Carousel(
                    snapshot.data, _scaffoldKey, "Más vendidos", "home");
              else
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 70.0),
                    child: CircularProgressIndicator(),
                  ),
                );
            },
          ),
          FutureBuilder(
            future: _publicationsProvider.getAllPublications(),
            builder: (context, AsyncSnapshot<List<PublicationModel>> snapshot) {
              if (snapshot.hasData)
                return Carousel(snapshot.data, _scaffoldKey, "Nuevos", "home");
              else
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 70.0),
                    child: CircularProgressIndicator(),
                  ),
                );
            },
          ),
        ],
      ),
    );
  }
}
