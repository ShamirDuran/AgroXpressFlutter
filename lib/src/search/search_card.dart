import 'package:agroxpress/src/models/publication_model.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget {
  final PublicationModel _publication;

  SearchCard(this._publication);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 13.0),
      child: InkWell(
        onTap: () {
          print(_publication.id);
          Navigator.pushNamed(context, "publication",
              arguments: _publication.id);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: FadeInImage(
                image: NetworkImage(_publication.image),
                placeholder: AssetImage("assets/images/image-placeholder.png"),
                fit: BoxFit.cover,
                width: 70.0,
                height: 85,
                fadeInDuration: Duration(microseconds: 3000),
              ),
            ),
            SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _publication.name,
                  style: TextStyle(fontSize: 17.0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                sb(2.0),
                Text(
                  _publication.productLocation,
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                sb(20),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$ ${_publication.unitPrice}",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(" /${_publication.getMeasurement()}"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
