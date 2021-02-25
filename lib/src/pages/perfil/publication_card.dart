import 'package:agroxpress/src/utils/utils.dart';
import 'package:flutter/material.dart';

class PublicationCard extends StatelessWidget {
  final height = 110.0;
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
              child: Image.asset(
                "assets/images/image-placeholder.png",
                height: height,
                fit: BoxFit.cover,
              ),
            ),
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
                      "Título publicación",
                      style: TextStyle(fontSize: 18.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    sb(2.0),
                    Text(
                      "2020 - Santander, Bucaramanga",
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 14.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    sb(20.0),
                    Row(
                      children: [
                        Text(
                          "\$ 5.500",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(" /Kg"),
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
