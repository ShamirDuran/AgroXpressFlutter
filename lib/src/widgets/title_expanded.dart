import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleExpanded extends StatelessWidget {
  final String title;

  TitleExpanded({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: Text(
          this.title,
          style: GoogleFonts.josefinSans(
              textStyle: TextStyle(
            color: Colors.white,
            fontSize: 60,
            fontWeight: FontWeight.bold,
          )),
        ),
      ),
    );
  }
}
