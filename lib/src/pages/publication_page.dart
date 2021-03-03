import 'package:agroxpress/src/bloc/purchase_bloc.dart';
import 'package:agroxpress/src/models/publication_model.dart';
import 'package:agroxpress/src/providers/publications_provider.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/circle_image.dart';
import 'package:agroxpress/src/widgets/full_width_button.dart';
import 'package:agroxpress/src/widgets/price_badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PublicationPage extends StatefulWidget {
  @override
  _PublicationPageState createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  String _id;
  PublicationsProvider _publicationProvider;
  GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = TextEditingController();

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
      key: _scaffoldKey,
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
                "Publicado el ${publication.creationDate.toString().substring(0, 10)}",
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 12.5,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(width: 13.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Publicacion - precio por unidad
            PriceBadge(
              text:
                  "\$ ${publication.getPriceFormated()} / ${publication.getMeasurement()}",
              radius: 50.0,
              pHor: 10.0,
              pVer: 7.0,
              size: 16.0,
              weight: FontWeight.w500,
            ),
            sb(6),
            // Publicacion - unidades disponibles
            Text(
              "Disponibles: ${publication.availableUnits.toString()}",
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
          sb(12),
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
          Image.asset("assets/images/payments.png"),
          _buyButton(publication)
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
            publication.totalVotes.toString(),
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

  Widget _buyButton(PublicationModel publication) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return FullWidthButton(
            title: "Solicitar producto",
            clickHandler: () => _showBottomSheet(publication),
          );
        });
  }

  _showBottomSheet(PublicationModel publication) {
    final textColor = Colors.black;
    final textSize = 16.0;
    final _bloc = PurchaseBloc();
    _bloc.availableUnits = publication.availableUnits;

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      isScrollControlled: true,
      context: _scaffoldKey.currentContext,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                publication.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    color: textColor),
              ),
              sb(10.0),
              Row(
                children: [
                  Text(
                    "Precio unidad:",
                    style: TextStyle(fontSize: textSize, color: textColor),
                  ),
                  Text(
                    " \$${publication.getPriceFormated()} /${publication.getMeasurement()}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: textSize,
                        color: textColor),
                  ),
                ],
              ),
              sb(3.0),
              Text(
                "Disponible: ${publication.availableUnits} ${publication.getMeasurement()}",
                style: TextStyle(fontSize: textSize, color: textColor),
              ),
              sb(3.0),
              StreamBuilder<Object>(
                  stream: _bloc.amountStream,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _controller,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Cantidad que desea comprar",
                        errorText: snapshot.error,
                      ),
                      onChanged: (value) {
                        _bloc.changeAmount = value;
                      },
                    );
                  }),
              sb(25.0),
              StreamBuilder<Object>(
                stream: _bloc.amountStream,
                builder: (context, snapshot) {
                  return FlatButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 13.0),
                    minWidth: double.infinity,
                    child: Text("Realizar compra"),
                    disabledColor: Colors.black38,
                    onPressed: (snapshot.hasData)
                        ? () => _purchase(publication, _bloc)
                        : null,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _purchase(PublicationModel publication, PurchaseBloc bloc) async {
    final resp =
        await _publicationProvider.purchase(publication.id, _controller.text);

    bloc.dispose();
    _controller.text = "";
    if (resp) {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
                title: Text("Compra exitosa"),
                actions: [
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () => Navigator.popAndPushNamed(
                        context, "publication",
                        arguments: publication.id),
                  )
                ],
              ));
    } else {
      showSnackBar("Error en la compra", _scaffoldKey);
      Navigator.pop(context);
    }
  }
}
