import 'package:agroxpress/src/pages/categories_page.dart';
import 'package:agroxpress/src/pages/create_publication/create_pub.dart';
import 'package:agroxpress/src/pages/create_publication/create_pub_details.dart';
import 'package:agroxpress/src/pages/create_publication/create_pub_location.dart';
import 'package:agroxpress/src/pages/favorites_page.dart';
import 'package:agroxpress/src/pages/home_page.dart';
import 'package:agroxpress/src/pages/login_page.dart';
import 'package:agroxpress/src/pages/notifications_page.dart';
import 'package:agroxpress/src/pages/perfil/my_publications_page.dart';
import 'package:agroxpress/src/pages/perfil/perfil_page.dart';
import 'package:agroxpress/src/pages/publication_page.dart';
import 'package:agroxpress/src/pages/register_page.dart';
import 'package:agroxpress/src/pages/my_shopping/purchases_page.dart';

final routes = {
  "home": (_) => HomePage(),
  "login": (_) => LoginPage(),
  "register": (_) => RegisterPage(),
  "notifications": (_) => NotificationsPage(),
  "shopping": (_) => PurchasesPage(),
  "favorites": (_) => FavoritesPage(),
  "perfil": (_) => PerfilPage(),
  "categories": (_) => CategoriesPage(),
  "create-publication": (_) => CreatePublication(),
  "create-pub-details": (_) => CreatePubDetails(),
  "create-pub-location": (_) => CreatePubLocation(),
  "publication": (_) => PublicationPage(),
  "my-publications": (_) => MyPublicationsPage(),
};
