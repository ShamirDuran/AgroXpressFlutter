import 'package:agroxpress/src/pages/my_shopping/shopping_card.dart';
import 'package:agroxpress/src/utils/styles.dart';
import 'package:agroxpress/src/utils/utils.dart';
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          sb(20),
          Text("Mis compras",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20.0)),
          sb(15.0),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return ShoppingCard();
            },
          ),
        ],
      ),
    );
  }
}
