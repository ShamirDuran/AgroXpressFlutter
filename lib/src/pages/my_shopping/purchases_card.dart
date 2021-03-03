import 'package:agroxpress/src/models/publication_model.dart';
import 'package:agroxpress/src/models/purchase_model.dart';
import 'package:agroxpress/src/providers/publications_provider.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:flutter/material.dart';

class PurchasesCard extends StatelessWidget {
  final height = 110.0;
  final PurchaseModel _purchase;
  final _publicationProvider = new PublicationsProvider();

  PurchasesCard(this._purchase);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // imagen de la publicaciones
            _buildImage(),
            // Breve descripción de la publicación
            Flexible(
              flex: 3,
              child: Container(
                margin: EdgeInsets.only(left: 12.0),
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titulo
                    Text(
                      _purchase.name,
                      style: TextStyle(fontSize: 18.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    sb(2.0),
                    // TODO: añadir fecha tambien
                    Text(
                      _purchase.date.toString().substring(0, 10),
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 14.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    sb(20.0),
                    Expanded(child: Text("")),
                    Text("Valor total: "),
                    Text(
                      "\$ ${_purchase.getPriceFormated()}",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.black26,
        ),
      ],
    );
  }

  Widget _buildImage() {
    return FutureBuilder(
      future: _publicationProvider.getPublication(_purchase.publication),
      builder:
          (BuildContext context, AsyncSnapshot<PublicationModel> snapshot) {
        if (snapshot.hasData) {
          final imageUrl = snapshot.data.image;
          return Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Image.network(
                imageUrl,
                height: height,
                fit: BoxFit.cover,
              ));
        } else {
          return Image.asset(
            "assets/images/image-placeholder.png",
            height: height,
            fit: BoxFit.cover,
          );
        }
      },
    );
  }
}
