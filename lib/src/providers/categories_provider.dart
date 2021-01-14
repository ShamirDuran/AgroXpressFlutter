import 'package:agroxpress/src/models/categorie_model.dart';

class ProducsProvider {
  Future<List<CategorieModel>> getCategories() async {
    final categories = new List<CategorieModel>();
    categories.add(CategorieModel(
        id: "1",
        name: "Vegetales",
        image:
            "https://agriculturers.com/wp-content/uploads/2015/10/vegetales-verduras.jpg"));
    categories.add(CategorieModel(
        id: "2",
        name: "Abono",
        image:
            "https://conceptodefinicion.de/wp-content/uploads/2016/05/Abono.jpg"));
    categories.add(CategorieModel(
        id: "3",
        name: "Herramientas",
        image:
            "https://agriculturaurbana.space/app/uploads/2018/08/herramientas-de-agricultura-1024x576.jpg"));
    categories.add(CategorieModel(
        id: "4",
        name: "Cereal",
        image:
            "https://media.enfasis.com/adjuntos/146/imagenes/000/071/0000071275.jpg"));
    categories.add(CategorieModel(
        id: "5",
        name: "Frutas",
        image:
            "https://flaxandkale.com/images/97cbeecffb8afd1f5a429fef66dd4854_37499?s=010e9fb531f720d06a00395f6a11805d&fm=png"));
    categories.add(CategorieModel(
        id: "6",
        name: "Granos",
        image:
            "https://media.enfasis.com/adjuntos/146/imagenes/000/108/0000108000.jpg"));
    categories.add(CategorieModel(
        id: "7",
        name: "Semillas",
        image:
            "https://viaorganica.org/wp-content/uploads/por-que-incluir-semillas-en-tu-alimentacion.jpg"));

    categories.add(CategorieModel(
        id: "1",
        name: "Vegetales",
        image:
            "https://agriculturers.com/wp-content/uploads/2015/10/vegetales-verduras.jpg"));
    categories.add(CategorieModel(
        id: "2",
        name: "Abono",
        image:
            "https://conceptodefinicion.de/wp-content/uploads/2016/05/Abono.jpg"));
    categories.add(CategorieModel(
        id: "5",
        name: "Frutas",
        image:
            "https://flaxandkale.com/images/97cbeecffb8afd1f5a429fef66dd4854_37499?s=010e9fb531f720d06a00395f6a11805d&fm=png"));
    categories.add(CategorieModel(
        id: "6",
        name: "Granos",
        image:
            "https://media.enfasis.com/adjuntos/146/imagenes/000/108/0000108000.jpg"));
    categories.add(CategorieModel(
        id: "5",
        name: "Frutas",
        image:
            "https://flaxandkale.com/images/97cbeecffb8afd1f5a429fef66dd4854_37499?s=010e9fb531f720d06a00395f6a11805d&fm=png"));
    categories.add(CategorieModel(
        id: "6",
        name: "Granos",
        image:
            "https://media.enfasis.com/adjuntos/146/imagenes/000/108/0000108000.jpg"));
    categories.add(CategorieModel(
        id: "7",
        name: "Semillas",
        image:
            "https://viaorganica.org/wp-content/uploads/por-que-incluir-semillas-en-tu-alimentacion.jpg"));

    return categories;
  }
}
