import 'dart:convert';

import 'package:agroxpress/src/models/publications_model.dart';
import 'package:http/http.dart' as http;

class PublicationsProvider {
  final _url = "https://agroxpress.herokuapp.com";

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
}
