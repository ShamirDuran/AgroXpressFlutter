import 'package:agroxpress/src/models/categorie_model.dart';
import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:dio/dio.dart';

class CategoriesProvider {
  final _url = "https://agroxpress.herokuapp.com";
  static UserPref _userPref = new UserPref();

  final headerOptions = new Options(
    contentType: "application/json",
    headers: {"authorization": _userPref.token},
  );

  Future<List<CategorieModel>> getCategories() async {
    try {
      final dio = new Dio();
      final resp = await dio.get("$_url/api/admin/category/get_all_categories",
          options: headerOptions);

      final categories = Categories.fromJsonList(resp.data["categories"]);

      return categories.items;
    } catch (e) {
      print("Error tratando de obtener las categorias: ${e.toString()}");
      return [];
    }
  }
}
