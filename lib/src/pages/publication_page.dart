import 'package:agroxpress/src/models/publications_model.dart';
import 'package:agroxpress/src/providers/publications_provider.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/circle_image.dart';
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
            return _publicationBody(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _publicationBody(PublicationModel publication) {
    return ListView(
      children: [
        // Publication images
        FadeInImage(
          placeholder: AssetImage("assets/images/image-placeholder.png"),
          image: NetworkImage(publication.image.length > 20
              ? publication.image
              : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuzUA0ySIB1K-zP-A5jZSv35tB-lBXztVz3A&usqp=CAU"),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 200),
          height: 220.0,
        ),

        _headerPublication(publication),
        _infoPublication(publication),
      ],
    );
  }

  Widget _headerPublication(PublicationModel publication) {
    final _header = Row(
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
                style: TextStyle(
                    fontSize: 25.0, fontWeight: FontWeight.bold, height: 1.05),
              ),
              SizedBox(height: 5.0),
              Text(
                // TODO: poner fecha desde backend
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
            // Publication price
            PriceBadge(
              text:
                  "\$ ${publication.unitPrice.toString()} ${getUnit(publication)}",
              radius: 50.0,
              pHor: 10.0,
              pVer: 7.0,
              size: 16.0,
              weight: FontWeight.w500,
            ),
            sb(6),
            // Publication available amount
            Text(
              "${getUnit(publication)} disponibles: ${publication.availableUnits.split(" ")[0]}",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 13.8,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        )
      ],
    );

    return // Publication title, date, price, qualification
        Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      color: Color(0xffEFEFEF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_location(publication), _qualification(publication)],
            ),
          ),
          sb(15),
          _header,
          sb(15),
        ],
      ),
    );
  }

  Widget _infoPublication(PublicationModel publication) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleSection("Descripción"),
          Text(
            publication.description,
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0),
          ),
          sb(25),
          _titleSection("Información del vendedor"),
          _ownerInfo(),
          sb(25),
          _titleSection("Métodos de pago"),
        ],
      ),
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

  Widget _titleSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18.4, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _ownerInfo() {
    return Column(
      children: [
        sb(5),
        Center(
            child: CircleImage(width: 80, height: 80, imgUrl: "", radius: 100)),
        sb(5),
        Text("Pepito Perez", style: TextStyle(fontWeight: FontWeight.w300)),
      ],
    );
  }
}
