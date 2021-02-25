import 'dart:convert';
import 'dart:io';
import 'package:agroxpress/src/models/publication_model.dart';
import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class PublicationsProvider {
  final _url = "https://agroxpress.herokuapp.com";
  final _prefs = UserPref();

  Future<bool> createPublication(
      PublicationModel publication, File image) async {
    final url = Uri.parse("$_url/api/farmer/create_publication");

    // Obtener el tipo de archivo, png - jpg - etc...
    final mimeType = mime(image.path).split("/");

    final headers = {
      "Content-Type": "application/json",
      "authorization": _prefs.token.toString(),
    };

    // Se prepara la petición y se agregan algunos campos
    var request = new http.MultipartRequest("POST", url)
      ..fields["name"] = publication.name
      ..fields["description"] = publication.description
      ..fields["recurrence"] = publication.recurrence.toString() ?? "0"
      ..fields["available_units"] = publication.availableUnits.toString()
      ..fields["measurement_unit"] = publication.measurementUnit
      ..fields["unit_price"] = publication.unitPrice.toString()
      ..fields["product_location"] = publication.productLocation
      ..fields["product"] = publication.productId ?? "Sin escpecificar"
      ..fields["recurrence"] = "0"
      ..fields["qualification"] = "5"
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath(
        "image",
        image.path,
        contentType: MediaType(mimeType[0], mimeType[1]),
      ));

    // Se manda la petición al servicio
    final streamResponse = await request.send();
    final resp = await http.Response.fromStream(streamResponse);

    // Se comprueba que se haya realizado correctamente
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print("Error al tratar crear la publicación: ${resp.body}");
      return false;
    }

    final decodedData = json.decode(resp.body);
    print("Publicación creada correctamente: $decodedData");
    return true;
  }

  Future<List<PublicationModel>> getAllPublications() async {
    final url = "$_url/api/client/get_all_publications";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final publications =
          Publications.fromJsonList(decodedData["publications"]);
      return publications.items;
    } else {
      print("GetAllPublications error request, $_url");
      return null;
    }
  }

  Future<PublicationModel> getPublication(String id) async {
    final uri = Uri.https(
        "agroxpress.herokuapp.com", "/api/client/get_publication_id", {
      'id': id,
    });

    final response = await http.get(uri, headers: {
      "Content-Type": "application/json",
      "authorization": _prefs.token,
    });

    final decodedData = json.decode(response.body);
    if (decodedData["ok"]) {
      return PublicationModel.fromJson(decodedData["publication"]);
    } else {
      print("GetPublicationId error request, ${decodedData["message"]}");
      return null;
    }
  }
}
