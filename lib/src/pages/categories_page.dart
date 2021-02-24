import 'package:agroxpress/src/models/categorie_model.dart';
import 'package:agroxpress/src/providers/categories_provider.dart';
import 'package:agroxpress/src/utils/styles.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final _categoriesProvider = new CategoriesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Categorias",
          style: TextStyle(fontWeight: kAppbarTitles),
        ),
      ),
      body: FutureBuilder(
        future: _categoriesProvider.getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategorieModel>> snapshot) {
          if (snapshot.hasData) {
            return _buildCategories(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildCategories(List<CategorieModel> categories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sb(5),
        _categoriesList(categories),
        sb(10),
      ],
    );
  }

  Widget _categoriesList(List<CategorieModel> categories) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: GridView.count(
        padding: EdgeInsets.only(top: 10.0, left: 8.0, right: 8.0),
        mainAxisSpacing: 7,
        crossAxisSpacing: 7,
        crossAxisCount: (size.width > 600) ? 3 : 2,
        childAspectRatio: 1.6,
        children: List.generate(
          categories.length,
          (index) {
            final categorie = categories[index];

            return _categoriaItem(categorie);
          },
        ),
      ),
    );
  }

  Widget _categoriaItem(CategorieModel categorie) {
    return GestureDetector(
      onTap: () {
        print("tap");
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7.0),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            categorie.name,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(categorie.imageUrl),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black45,
                BlendMode.darken,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
