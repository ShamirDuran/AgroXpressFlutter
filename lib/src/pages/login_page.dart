import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/background_poster.dart';
import 'package:agroxpress/src/widgets/input_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundPoster(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              _title(),
              InputField(
                  hintText: "Email",
                  password: false,
                  icon: Icons.email_outlined,
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next),
              sb(20.0),
              InputField(
                  hintText: "Contraseña",
                  password: true,
                  icon: Icons.lock_outline,
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.done),
            ],
          ),
        ),
      ],
    );
  }

  Widget _title() {
    return Flexible(
      child: Center(
        child: Text(
          "AgroXpress",
          style: TextStyle(
            color: Colors.white,
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
