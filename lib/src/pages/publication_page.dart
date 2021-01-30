import 'package:agroxpress/src/models/publications_model.dart';
import 'package:agroxpress/src/providers/publications_provider.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/price_badge.dart';
import 'package:flutter/material.dart';

class PublicationPage extends StatefulWidget {
  @override
  _PublicationPageState createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  String _id;
  PublicationsProvider _publicationProvider;

  @override
  void initState() {
    super.initState();
    _publicationProvider = PublicationsProvider();
    new Future.delayed(Duration.zero, () {
      _id = ModalRoute.of(context).settings.arguments;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Detalles publicación",
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: FutureBuilder(
        future: _publicationProvider.getPublication(this._id),
        builder:
            (BuildContext context, AsyncSnapshot<PublicationModel> snapshot) {
          if (snapshot.hasData) {
            return _pub(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _pub(PublicationModel publication) {
    return ListView(
      children: [
        FadeInImage(
          placeholder: AssetImage("assets/images/image-placeholder.png"),
          image: NetworkImage(publication.image.length > 10
              ? publication.image
              : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuzUA0ySIB1K-zP-A5jZSv35tB-lBXztVz3A&usqp=CAU"),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 200),
          height: 220.0,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _location(publication),
                    _qualification(publication)
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              _header(publication),
              SizedBox(height: 15.0),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Descripción",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 5.0),
              Text(
                publication.description,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14.0),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _header(PublicationModel publication) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                publication.name,
                overflow: TextOverflow.visible,
                style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 5.0),
              // TODO: poner fecha desde backend
              Text(
                "Publicado el 14/12/2020",
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
        SizedBox(width: 15.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PriceBadge(
              text:
                  "\$ ${publication.unitPrice.toString()} ${getUnit(publication)}",
              radius: 10.0,
              size: 17.0,
              pHor: 10.0,
              pVer: 7.6,
              weight: FontWeight.w300,
            ),
            SizedBox(height: 6.0),
            Text(
              "${getUnit(publication)} disponibles: ${publication.availableUnits.split(" ")[0]}",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        )
      ],
    );
  }

  Widget _qualification(PublicationModel publication) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.yellow, size: 20.0),
        Align(
          alignment: Alignment.center,
          child: Text(
            publication.qualification.toString(),
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13.0),
          ),
        ),
      ],
    );
  }

  Widget _location(PublicationModel publication) {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, color: Colors.grey, size: 20.0),
        Text(
          publication.productLocation,
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 13.0),
        ),
      ],
    );
  }
}
