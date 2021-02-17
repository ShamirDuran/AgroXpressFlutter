import 'package:agroxpress/src/models/publications_model.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/full_width_button.dart';
import 'package:agroxpress/src/widgets/create_pub_input.dart';
import 'package:agroxpress/src/widgets/create_pub_title.dart';
import 'package:flutter/material.dart';

class CreatePubDetails extends StatefulWidget {
  @override
  _CreatePubDetailsState createState() => _CreatePubDetailsState();
}

class _CreatePubDetailsState extends State<CreatePubDetails> {
  PublicationModel _publication;
  TextEditingController _availableUnitsController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  bool _checkAvailableunits;
  bool _priceCheck;
  List _measurementUnits = [
    "Kilogramos (Kg)",
    "Gramos (g)",
    "Libras (lb)",
    "Tonelada (t)"
  ];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentUnit;

  @override
  void initState() {
    super.initState();
    _checkAvailableunits = false;
    _priceCheck = false;
    _dropDownMenuItems = getDropDownMenuitems();
    _currentUnit = _dropDownMenuItems[0].value;
    _availableUnitsController.addListener(_validateAvailableUnits);
    _priceController.addListener(_validatePrice);
  }

  @override
  void dispose() {
    _availableUnitsController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> getDropDownMenuitems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String unit in _measurementUnits) {
      items.add(new DropdownMenuItem(
        value: unit,
        child: Text(unit),
      ));
    }
    return items;
  }

  _validateAvailableUnits() {
    if (_availableUnitsController.text.length >= 1) {
      _checkAvailableunits = true;
    } else {
      _checkAvailableunits = false;
    }
    setState(() {});
  }

  _validatePrice() {
    if (_priceController.text.length >= 2) {
      _priceCheck = true;
    } else {
      _priceCheck = false;
    }
    print('$_priceCheck $_checkAvailableunits');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _publication = ModalRoute.of(context).settings.arguments;
    return Scaffold(
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
                  CreatePubTitle(
                      title: "Selecciona la unidad en la que desees vender"),
                  Center(
                    child: DropdownButton(
                      value: _currentUnit,
                      items: _dropDownMenuItems,
                      onChanged: (value) {
                        setState(() {
                          _currentUnit = value;
                        });
                        print(_currentUnit);
                      },
                    ),
                  ),
                  sb(20.0),
                  // TODO: habiitar solo enteros
                  CreatePubTitle(
                      title: "¿Cuantas unidades tienes disponibles?"),
                  Container(
                    width: 200.0,
                    child: CreatePubInput(
                      controller: _availableUnitsController,
                      label: "Ej.: 1500",
                      type: TextInputType.number,
                      align: TextAlign.center,
                    ),
                  ),
                  sb(20),
                  CreatePubTitle(title: "Indica el precio por unidad"),
                  Container(
                    width: 200.0,
                    child: CreatePubInput(
                      controller: _priceController,
                      label: "Ej.: 2500",
                      type: TextInputType.number,
                      align: TextAlign.center,
                      prefix: Text("\$"),
                    ),
                  ),
                  sb(20),
                  Expanded(child: Text("")),
                  FullWidthButton(
                    clickHandler: _checkAvailableunits && _priceCheck
                        ? __navigateThirdStep
                        : null,
                    title: "Continuar",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  __navigateThirdStep() {
    _publication.measurementUnit = _currentUnit;
    _publication.availableUnits = _availableUnitsController.text;
    _publication.unitPrice = int.parse(_priceController.text);

    // TODO: Pernsar si cambiar ruta a mapa mejor
    Navigator.pushNamed(
      context,
      "create-pub-location",
      arguments: _publication,
    );
  }
}
