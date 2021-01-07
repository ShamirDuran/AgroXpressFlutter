import 'package:agroxpress/src/search/search_delegate.dart';
import 'package:agroxpress/src/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      drawer: DrawerMenu(),
      body: Center(
        child: Text("HomePage"),
      ),
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

  GestureDetector _searchAppBar() {
    return GestureDetector(
      // Search delegate action
      onTap: () => showSearch(context: context, delegate: DataSearch()),
      child: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.symmetric(
          vertical: 4.4,
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
      ),
    );
  }
}
