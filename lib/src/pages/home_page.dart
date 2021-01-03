import 'package:agroxpress/src/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      drawer: buildDrawer(context),
      body: Center(
        child: Text("HomePage"),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return DrawerMenu();
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.indigoAccent,
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
      title: searchAppBar(),
      centerTitle: true,
    );
  }

  GestureDetector searchAppBar() {
    return GestureDetector(
      onTap: () => print("tap search"),
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
