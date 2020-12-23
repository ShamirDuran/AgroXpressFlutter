import 'package:agroxpress/src/pages/login_page.dart';
import 'package:agroxpress/src/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primaryColor: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      title: 'AgroXpress',
      initialRoute: "login",
      routes: {
        "login": (_) => LoginPage(),
        "register": (_) => RegisterPage(),
      },
    );
  }
}
