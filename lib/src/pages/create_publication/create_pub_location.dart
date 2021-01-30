import 'package:agroxpress/src/models/publications_model.dart';
import 'package:agroxpress/src/providers/publications_provider.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/create_pub_input.dart';
import 'package:agroxpress/src/widgets/create_pub_title.dart';
import 'package:flutter/material.dart';

class CreatePubLocation extends StatefulWidget {
  @override
  _CreatePubLocationState createState() => _CreatePubLocationState();
}

class _CreatePubLocationState extends State<CreatePubLocation> {
  PublicationModel _publication;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _locationController = TextEditingController();
  bool _checkLocation;
  final _publicationProvider = PublicationsProvider();

  @override
  void initState() {
    super.initState();
    _checkLocation = false;
    _locationController.addListener(_validateLocation);
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  _validateLocation() {
    if (_locationController.text.length >= 6) {
      _checkLocation = true;
    } else {
      _checkLocation = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _publication = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Crear publicación",
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  CreatePubTitle(title: "Indica la ubicación del producto"),
                  CreatePubInput(
                    controller: _locationController,
                    label: "Ej.: Bucaramanga, Santander",
                    type: TextInputType.text,
                    minLines: 1,
                    maxLines: 1,
                    helper: "Debe tener almenos 6 caracteres",
                    maxLength: 30,
                  ),
                  Expanded(child: Text("")),
                  _continueButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _continueButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: _checkLocation ? () => _createPub() : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            "Continuar",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 17.0),
          ),
        ),
      ),
    );
  }

  _createPub() async {
    _publication.productLocation = _locationController.text;
    final resp = await _publicationProvider.createPublication(_publication);

    if (resp) {
      showSnackBar("Publicación creadata correctamente", _scaffoldKey);
      Navigator.pushNamedAndRemoveUntil(context, "home", (r) => false);
    } else {
      showSnackBar("Error al intentar crear la publicación", _scaffoldKey);
    }
  }
}