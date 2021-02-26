import 'dart:io';
import 'package:agroxpress/src/routes/routes.dart';
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
      initialRoute: "home",
      routes: routes,
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
