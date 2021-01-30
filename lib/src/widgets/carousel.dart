import 'package:agroxpress/src/models/publications_model.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/price_badge.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  final List<PublicationModel> data;

  Carousel(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 275.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) =>
            _card(context, data[index]),
      ),
    );
  }

  Widget _card(BuildContext context, PublicationModel publication) {
    final imageWidth = 125.0;
    final imageHeight = 175.0;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "publication",
          arguments: publication.id),
      child: Container(
        width: imageWidth,
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(3.0),
              child: FadeInImage(
                placeholder: AssetImage("assets/images/image-placeholder.png"),
                image: NetworkImage(publication.image.length > 20
                    ? publication.image
                    : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuzUA0ySIB1K-zP-A5jZSv35tB-lBXztVz3A&usqp=CAU"),
                fadeInDuration: Duration(milliseconds: 300),
                fit: BoxFit.cover,
                width: imageWidth,
                height: imageHeight,
              ),
            ),
            sb(5.0),
            // Title
            Text(
              publication.name,
              textAlign: TextAlign.start,
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
            ),
            sb(1.0),
            // Location
            Text(
              publication.productLocation,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style:
                  Theme.of(context).textTheme.caption.copyWith(fontSize: 11.5),
            ),
            sb(5.0),
            // Price
            PriceBadge(
              text: "\$ ${publication.unitPrice} ${getUnit(publication)}",
              radius: 2.0,
              size: 14.0,
            ),
          ],
        ),
      ),
    );
  }
}
