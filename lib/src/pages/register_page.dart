import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/background_poster.dart';
import 'package:agroxpress/src/widgets/divider_or.dart';
import 'package:agroxpress/src/widgets/input_field.dart';
import 'package:agroxpress/src/widgets/rounded_button.dart';
import 'package:agroxpress/src/widgets/title_expanded.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundPoster(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              TitleExpanded(title: "Registro"),
              InputField(
                  hintText: "Nombre",
                  password: false,
                  icon: Icons.person,
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next),
              InputField(
                  hintText: "Correo",
                  password: false,
                  icon: Icons.email_outlined,
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next),
              InputField(
                  hintText: "Contrasela",
                  password: true,
                  icon: Icons.lock_outline,
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.next),
              InputField(
                  hintText: "Confirme la contraseña",
                  password: true,
                  icon: Icons.lock_outline,
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.done),
              sb(40.0),
              RoundedButton(text: "Registrarse"),
              DividerOr(),
              yaTengoCuenta(context),
              sb(27),
            ],
          ),
        )
      ],
    );
  }

  Widget yaTengoCuenta(BuildContext context) {
    return GestureDetector(
      // TODO: revisar el navigator
      onTap: () => Navigator.pushNamed(context, "login"),
      child: Container(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Text(
          "¿Ya tienes una cuenta? Login",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
              ),
        ),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.white))),
      ),
    );
  }
}
