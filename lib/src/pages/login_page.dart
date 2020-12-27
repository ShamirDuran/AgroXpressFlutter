import 'package:agroxpress/src/bloc/login_bloc.dart';
import 'package:agroxpress/src/widgets/divider_or.dart';
import 'package:flutter/material.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/background_poster.dart';
import 'package:agroxpress/src/widgets/input_field.dart';
import 'package:agroxpress/src/widgets/rounded_button.dart';
import 'package:agroxpress/src/widgets/title_expanded.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<LoginBloc>(context);

    return Stack(
      children: [
        BackgroundPoster(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Title agroxpress
                TitleExpanded(
                  title: "AgroXpress",
                  padTop: 0.16,
                  padBottom: 0.15,
                ),
                // Email
                StreamBuilder<Object>(
                    stream: _bloc.emailStream,
                    builder: (context, snapshot) {
                      return InputField(
                        hintText: "Correo",
                        password: false,
                        icon: Icons.email_outlined,
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        error: snapshot.error,
                        changeValue: _bloc.changeEmail,
                      );
                    }),
                sb(10.0),
                // Password
                StreamBuilder<Object>(
                    stream: _bloc.passwordStream,
                    builder: (context, snapshot) {
                      return InputField(
                        hintText: "Contraseña",
                        password: true,
                        icon: Icons.lock,
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.done,
                        error: snapshot.error,
                        changeValue: _bloc.changePassword,
                      );
                    }),
                // Forgot pwd link
                olvidePwd(context),
                sb(45),
                // Login button
                StreamBuilder<Object>(
                    stream: _bloc.formValidStream,
                    builder: (context, snapshot) {
                      return RoundedButton(
                        text: "Login",
                        onPress: (snapshot.hasData)
                            ? () => _login(_bloc, context)
                            : null,
                      );
                    }),
                DividerOr(),
                // Register link
                crearNuevaCuenta(context),
                sb(27.0)
              ],
            ),
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

  _login(LoginBloc bloc, BuildContext context) async {
    print("login...");
  }
}
