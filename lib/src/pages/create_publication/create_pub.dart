import 'package:agroxpress/src/models/publication_model.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/create_pub_input.dart';
import 'package:agroxpress/src/widgets/create_pub_title.dart';
import 'package:agroxpress/src/widgets/full_width_button.dart';
import 'package:flutter/material.dart';

class CreatePublication extends StatefulWidget {
  @override
  _CreatePublicationState createState() => _CreatePublicationState();
}

class _CreatePublicationState extends State<CreatePublication> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  bool _nameCheck;
  bool _descriptionCheck;

  @override
  void initState() {
    super.initState();
    _nameCheck = false;
    _descriptionCheck = false;
    _nameController.addListener(_validateName);
    _descriptionController.addListener(_validateDescription);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  _validateName() {
    if (_nameController.text.length >= 3) {
      _nameCheck = true;
    } else {
      _nameCheck = false;
    }
    setState(() {});
  }

  _validateDescription() {
    if (_descriptionController.text.length >= 10) {
      _descriptionCheck = true;
    } else {
      _descriptionCheck = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
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
                  CreatePubTitle(
                      title:
                          "Escribe el título y descripción de la publicación"),
                  CreatePubInput(
                    controller: _nameController,
                    label: "Ej.: Papa criolla cultivada con no se que",
                    maxLength: 50,
                    type: TextInputType.text,
                    helper: "Mínimo 3 caracteres",
                  ),
                  sb(20.0),
                  CreatePubTitle(
                      title: "Escribe la descripción de lo que deseas vender"),
                  CreatePubInput(
                    controller: _descriptionController,
                    label:
                        "Ej.: Papa criolla cultivada con las mejores practicas para que crescan muy bien. Utilizamos los mejores abonos",
                    maxLength: 150,
                    type: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    helper: "Mínimo 10 caracteres",
                  ),
                  Expanded(child: Text("")),
                  FullWidthButton(
                    clickHandler: _nameCheck && _descriptionCheck
                        ? _navigateSecondStep
                        : null,
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

  _navigateSecondStep() {
    Navigator.pushNamed(
      context,
      "create-pub-details",
      arguments: new PublicationModel(
          name: _nameController.text, description: _descriptionController.text),
    );
  }
}
