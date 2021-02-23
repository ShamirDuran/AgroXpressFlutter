import 'dart:convert';

import 'package:agroxpress/src/models/publications_model.dart';
import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:http/http.dart' as http;

class PublicationsProvider {
  final _url = "https://agroxpress.herokuapp.com";
  final _prefs = UserPref();

  Future<bool> createPublication(PublicationModel publication) async {
    // Eliminar este
    publication.recurrence = 0;
    publication.totalVotes = 0;
    publication.productId = "Sin especificar";

    final resp = await http.post(
      "$_url/api/farmer/create_publication",
      body: publicationModelToJsonRegister(publication),
      headers: {
        "Content-Type": "application/json",
        "authorization": _prefs.token
      },
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp["ok"] == true)
      return true;
    else
      return decodedResp["err"]["message"];
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
