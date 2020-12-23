import 'package:agroxpress/src/widgets/divider_or.dart';
import 'package:flutter/material.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/background_poster.dart';
import 'package:agroxpress/src/widgets/input_field.dart';
import 'package:agroxpress/src/widgets/rounded_button.dart';
import 'package:agroxpress/src/widgets/title_expanded.dart';

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
              TitleExpanded(title: "AgroXpress"),
              InputField(
                  hintText: "Correo",
                  password: false,
                  icon: Icons.email_outlined,
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next),
              sb(10.0),
              InputField(
                  hintText: "Contraseña",
                  password: true,
                  icon: Icons.lock,
                  inputType: TextInputType.name,
                  inputAction: TextInputAction.done),
              olvidePwd(context),
              sb(45),
              RoundedButton(
                text: "Login",
              ),
              DividerOr(),
              crearNuevaCuenta(context),
              sb(27.0)
            ],
          ),
        ),
      ],
    );
  }

  Widget olvidePwd(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Tap forgot password");
      },
      child: Text("¿Olvidaste tu contraseña?",
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.white)),
    );
  }

  Widget crearNuevaCuenta(BuildContext context) {
    return GestureDetector(
      // TODO: revisar el navigator
      onTap: () => Navigator.pushNamed(context, "register"),
      child: Container(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Text(
          "Crear nueva cuenta",
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
