import 'package:agroxpress/src/models/purchase_model.dart';
import 'package:agroxpress/src/pages/my_shopping/purchases_card.dart';
import 'package:agroxpress/src/providers/user_provider.dart';
import 'package:agroxpress/src/utils/styles.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:flutter/material.dart';

class PurchasesPage extends StatelessWidget {
  final _userProvider = new UserProvider();

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
      body: FutureBuilder(
        future: _userProvider.getMyPurchases(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PurchaseModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return Center(
                  child: Text("Aqui podras ver las compras que realices"));
            } else {
              final list = snapshot.data.reversed.toList();
              return _buildBody(list);
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody(List<PurchaseModel> data) {
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
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return PurchasesCard(data[index]);
            },
          ),
        ],
      ),
    );
  }
}
