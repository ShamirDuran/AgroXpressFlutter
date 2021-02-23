import 'dart:io';

import 'package:agroxpress/src/pages/categories_page.dart';
import 'package:agroxpress/src/pages/create_publication/create_pub.dart';
import 'package:agroxpress/src/pages/create_publication/create_pub_details.dart';
import 'package:agroxpress/src/pages/create_publication/create_pub_location.dart';
import 'package:agroxpress/src/pages/favorites_page.dart';
import 'package:agroxpress/src/pages/home_page.dart';
import 'package:agroxpress/src/pages/login_page.dart';
import 'package:agroxpress/src/pages/notifications_page.dart';
import 'package:agroxpress/src/pages/perfil_page.dart';
import 'package:agroxpress/src/pages/publication_page.dart';
import 'package:agroxpress/src/pages/register_page.dart';
import 'package:agroxpress/src/pages/shopping_page.dart';
import 'package:agroxpress/src/pages/test_page.dart';
import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  // User preferences
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserPref();
  await prefs.initPref();

  // Transparent status bar
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.light));

  // Disable landscape mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _prefs = new UserPref();
    print('token: ${_prefs.token}');

    HttpOverrides.global = new MyHttpOverrides();

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.indigoAccent,
        disabledColor: Colors.indigo[200],
        fontFamily: "Lato",
      ),
      debugShowCheckedModeBanner: false,
      title: 'AgroXpress',
      initialRoute: "test",
      routes: {
        "home": (_) => HomePage(),
        "login": (_) => LoginPage(),
        "register": (_) => RegisterPage(),
        "notifications": (_) => NotificationsPage(),
        "shopping": (_) => ShoppingPage(),
        "favorites": (_) => FavoritesPage(),
        "perfil": (_) => PerfilPage(),
        "categories": (_) => CategoriesPage(),
        "create-publication": (_) => CreatePublication(),
        "create-pub-details": (_) => CreatePubDetails(),
        "create-pub-location": (_) => CreatePubLocation(),
        "publication": (_) => PublicationPage(),
        "test": (_) => TestPage(),
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
