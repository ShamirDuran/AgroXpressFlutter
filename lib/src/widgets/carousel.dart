import 'package:agroxpress/src/models/publications_model.dart';
import 'package:agroxpress/src/utils/utils.dart';
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
    return Container(
      width: imageWidth,
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3.0),
            child: FadeInImage(
              placeholder: AssetImage("assets/images/image-placeholder.png"),
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuzUA0ySIB1K-zP-A5jZSv35tB-lBXztVz3A&usqp=CAU"),
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
            overflow: TextOverflow.visible,
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
          ),
          sb(1.0),
          // Location
          Text(
            "Bucaramanga, Santander",
            textAlign: TextAlign.start,
            overflow: TextOverflow.visible,
            style: Theme.of(context).textTheme.caption.copyWith(fontSize: 11.5),
          ),
          sb(5.0),
          // Price
          Container(
            width: 60.0,
            padding: EdgeInsets.symmetric(vertical: 2.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "\$ 2.000",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
