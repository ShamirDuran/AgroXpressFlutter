import 'package:flutter/material.dart';
import 'dart:io';
import 'package:agroxpress/src/models/publication_model.dart';
import 'package:agroxpress/src/providers/publications_provider.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/create_pub_input.dart';
import 'package:agroxpress/src/widgets/create_pub_title.dart';
import 'package:agroxpress/src/widgets/full_width_button.dart';
import 'package:image_picker/image_picker.dart';

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
  File _image;

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
                  _showImage(),
                  CreatePubTitle(title: "Agrega una foto del producto"),
                  sb(10),
                  OutlineButton(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                    textColor: Theme.of(context).primaryColor,
                    child: Text("Agregar foto"),
                    onPressed: _showBottomSheet,
                  ),
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
                  FullWidthButton(
                    clickHandler: _checkLocation ? _createPub : null,
                    title: "Continuar",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
      context: _scaffoldKey.currentContext,
      builder: (context) => Wrap(
        children: [
          ListTile(
            title: Text("Galería"),
            leading: Icon(Icons.image),
            onTap: () {
              Navigator.pop(context);
              _procesarImagen(ImageSource.gallery);
            },
          ),
          ListTile(
            title: Container(child: Text("Cámara")),
            leading: Container(
              padding: EdgeInsets.only(top: 1),
              child: Icon(Icons.photo_camera),
            ),
            onTap: () {
              Navigator.pop(context);
              _procesarImagen(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  // Si no se ha seleccionado una imagen muestra una de relleno
  Widget _showImage() {
    final height = 260.0;
    return _image == null
        ? Image.asset("assets/images/image-placeholder.png",
            width: double.infinity, height: height, fit: BoxFit.cover)
        : Image.file(_image, height: height, fit: BoxFit.cover);
  }

  _procesarImagen(ImageSource origen) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: origen);

    setState(() {
      if (pickedFile != null)
        _image = File(pickedFile.path);
      else
        print("No se pudo tomar una foto");
    });
  }

  _createPub() async {
    _publication.productLocation = _locationController.text;
    final resp =
        await _publicationProvider.createPublication(_publication, _image);

    if (resp) {
      showSnackBar("Publicación creadata correctamente", _scaffoldKey);
      Navigator.pushNamedAndRemoveUntil(context, "home", (r) => false);
    } else {
      showSnackBar("Error al intentar crear la publicación", _scaffoldKey);
    }
  }
}
