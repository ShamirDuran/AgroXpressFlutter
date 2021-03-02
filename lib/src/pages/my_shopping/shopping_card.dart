import 'package:agroxpress/src/utils/utils.dart';
import 'package:flutter/material.dart';

class ShoppingCard extends StatelessWidget {
  final height = 110.0;

  @override
  Widget build(BuildContext context) {
    print("se llamo");
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
                  image: AssetImage("assets/images/image-placeholder.png"),
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
                    // Titulo
                    Text(
                      "Titulo publicación",
                      style: TextStyle(fontSize: 18.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    sb(2.0),
                    // TODO: añadir fecha tambien
                    Text(
                      "2021-03-05",
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 14.0),
                      overflow: TextOverflow.ellipsis,
                    ),
                    sb(20.0),
                    Expanded(child: Text("")),
                    Text("Valor total: "),
                    Text(
                      "\$ 3,500",
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
}
