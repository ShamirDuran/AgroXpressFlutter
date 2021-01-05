import 'package:agroxpress/src/pages/home_page.dart';
import 'package:agroxpress/src/pages/perfil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:agroxpress/src/pages/login_page.dart';
import 'package:agroxpress/src/pages/register_page.dart';
import 'package:agroxpress/src/utils/user_prefs.dart';

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

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.indigoAccent,
        disabledColor: Colors.indigo[200],
      ),
      debugShowCheckedModeBanner: false,
      title: 'AgroXpress',
      initialRoute: (_prefs.token != "") ? "home" : "login",
      routes: {
        "home": (_) => HomePage(),
        "login": (_) => LoginPage(),
        "register": (_) => RegisterPage(),
        "perfil": (_) => PerfilPage(),
      },
    );
  }
}
