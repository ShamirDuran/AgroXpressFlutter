import 'package:agroxpress/src/models/publication_model.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:flutter/material.dart';

class PublicationCard extends StatelessWidget {
  final PublicationModel _publication;
  final height = 110.0;

  PublicationCard(this._publication);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // imagen de la publicaciones
            Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: FadeInImage(
                  placeholder:
                      AssetImage("assets/images/image-placeholder.png"),
                  image: NetworkImage(_publication.image),
                  height: height,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(milliseconds: 300),
                )),
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
                    Text(
                      _publication.name,
                      style: TextStyle(fontSize: 18.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    sb(2.0),
                    // TODO: añadir fecha tambien
                    Text(
                      _publication.productLocation,
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 14.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    sb(20.0),
                    Row(
                      children: [
                        Text(
                          "\$ ${_publication.unitPrice}",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(" /${_publication.getMeasurement()}"),
                      ],
                    )
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
}
