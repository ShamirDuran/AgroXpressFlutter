import 'package:agroxpress/src/bloc/login_bloc.dart';
import 'package:agroxpress/src/bloc/register_bloc.dart';
import 'package:agroxpress/src/pages/login_page.dart';
import 'package:agroxpress/src/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => LoginBloc()),
        Provider(create: (context) => RegisterBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme:
              GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
          primaryColor: Colors.indigo,
          disabledColor: Colors.indigo[200],
        ),
        debugShowCheckedModeBanner: false,
        title: 'AgroXpress',
        initialRoute: "login",
        routes: {
          "login": (_) => LoginPage(),
          "register": (_) => RegisterPage(),
        },
      ),
    );
  }
}
