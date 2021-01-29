import 'package:agroxpress/src/providers/publications_provider.dart';
import 'package:agroxpress/src/search/search_delegate.dart';
import 'package:agroxpress/src/utils/utils.dart';
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
      padding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_outlined,
            color: Colors.grey[400],
          ),
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
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Column(
        children: [
          _offer(),
        ],
      ),
    );
  }

  Widget _offer() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Oferta",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          sb(10),
          // FutureBuilder(
          //   future: _publicationsProvider.getOfferPublications(),
          //   builder: (BuildContext context,
          //       AsyncSnapshot<List<PublicationModel>> snapshot) {
          //     if (snapshot.hasData) {
          //       return _cardItem();
          //     } else {
          //       return CircularProgressIndicator();
          //     }
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _cardItem() {
    return Container(
      width: 150.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              placeholder: AssetImage("assets/images/image-placeholder.png"),
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuzUA0ySIB1K-zP-A5jZSv35tB-lBXztVz3A&usqp=CAU"),
              fadeInDuration: Duration(milliseconds: 300),
              fit: BoxFit.cover,
              width: 150.0,
              height: 200.0,
            ),
          ),
          sb(5.0),
          Text(
            "Papa criolla",
            textAlign: TextAlign.start,
            overflow: TextOverflow.visible,
            style: TextStyle(fontSize: 15.0),
          ),
          sb(1.0),
          Text(
            "Bucaramanga, Santander",
            textAlign: TextAlign.start,
            overflow: TextOverflow.visible,
            style: Theme.of(context).textTheme.caption,
          ),
          sb(5.0),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "\$ 2.000 /kg",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
