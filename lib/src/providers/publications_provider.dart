import 'dart:convert';
import 'dart:io';
import 'package:agroxpress/src/models/publication_model.dart';
import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:mime_type/mime_type.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class PublicationsProvider {
  final _url = "https://agroxpress.herokuapp.com";
  static final _prefs = UserPref();

  final headerOptions = new Options(
    contentType: "application/json",
    headers: {"authorization": _prefs.token},
  );

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

  // Obtiene todas las publicaciones registradas hasta el momento
  Future<List<PublicationModel>> getAllPublications() async {
    final url = "$_url/api/client/get_all_publications";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final publications =
          Publications.fromJsonList(decodedData["publications"]);
      return publications.items.reversed.toList();
    } else {
      print("GetAllPublications error request, $_url");
      return null;
    }
  }

  /// Obtiene los detalles de una publicación mediante el id de esta
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

  /// Obtiene las publicaciones para el usuario logueado
  Future<List<PublicationModel>> getUserPublications() async {
    try {
      final url = "$_url/api/farmer/get_user_publications";
      final resp = await Dio().get(url, options: headerOptions);
      final publications =
          Publications.fromJsonList(resp.data["user_publications"]);

      return publications.items;
    } catch (e) {
      print("Error obteniendo mis publicaciones: ${e.toString()}");
      return [];
    }
  }

  /// Obtiene todas las publicaciones que en el nombre contengan el string de busqueda
  Future<List<PublicationModel>> getSearch(String query) async {
    try {
      final resp = await Dio().get(
        "$_url/api/client/get_publication_by_term",
        queryParameters: {"term": query},
        options: headerOptions,
      );

      final publications = Publications.fromJsonList(resp.data["publications"]);
      return publications.items;
    } catch (e) {
      print("Error al obtener busqueda: ${e.toString()}");
      return [];
    }
  }

  /// Simula una compra
  Future<bool> purchase(String publicationId, String quantity) async {
    try {
      final resp = await Dio().post(
        "$_url/api/user/save_history",
        queryParameters: {
          "publication_id": publicationId,
          "quantity": quantity,
        },
        options: headerOptions,
      );

      return resp.data["ok"];
    } catch (e) {
      print("Error al realizar la compra: ${e.toString()}");
      return false;
    }
  }
}
