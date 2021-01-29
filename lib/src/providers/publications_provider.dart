import 'dart:convert';

import 'package:agroxpress/src/models/publications_model.dart';
import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:http/http.dart' as http;

class PublicationsProvider {
  final _url = "https://agroxpress.herokuapp.com";
  final _prefs = UserPref();

  Future<bool> createPublication(PublicationModel publication) async {
    publication.recurrence = 0;
    publication.qualification = 0;
    publication.product = "Sin especificar";

    final resp = await http.post(
      "$_url/api/farmer/create_publication",
      body: publicationModelToJsonRegister(publication),
      headers: {
        "Content-Type": "application/json",
        "authorization": _prefs.token
      },
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp["ok"] == true) {
      print(decodedResp);
      return true;
    } else {
      print(decodedResp);
      return decodedResp["err"]["message"];
    }
  }
}
