import 'package:agroxpress/src/bloc/register_bloc.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/background_poster.dart';
import 'package:agroxpress/src/widgets/divider_or.dart';
import 'package:agroxpress/src/widgets/input_field.dart';
import 'package:agroxpress/src/widgets/rounded_button.dart';
import 'package:agroxpress/src/widgets/title_expanded.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<RegisterBloc>(context);

    return Stack(
      children: [
        BackgroundPoster(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                TitleExpanded(
                  title: "Registro",
                  padTop: 0.16,
                  padBottom: 0.032,
                ),
                // Name
                StreamBuilder<Object>(
                  stream: _bloc.nameStream,
                  builder: (context, snapshot) {
                    return InputField(
                      hintText: "Nombre",
                      password: false,
                      icon: Icons.person,
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      error: snapshot.error,
                      changeValue: _bloc.changeName,
                    );
                  },
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
                // Password
                StreamBuilder<Object>(
                    stream: _bloc.passwordStream,
                    builder: (context, snapshot) {
                      return InputField(
                        hintText: "Contraseña",
                        password: true,
                        icon: Icons.lock_outline,
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        error: snapshot.error,
                        changeValue: _bloc.changePassword,
                      );
                    }),
                // Confirm password
                StreamBuilder<Object>(
                    stream: _bloc.rePasswordStream,
                    builder: (context, snapshot) {
                      return InputField(
                        hintText: "Confirme la contraseña",
                        password: true,
                        icon: Icons.lock_outline,
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.done,
                        error: snapshot.error,
                        changeValue: _bloc.changeRePassword,
                      );
                    }),
                sb(40.0),
                // Register button
                StreamBuilder<Object>(
                    stream: _bloc.formValidStream,
                    builder: (context, snapshot) {
                      return RoundedButton(
                        text: "Registrarse",
                        onPress: (snapshot.hasData)
                            ? () => _register(_bloc, context)
                            : null,
                      );
                    }),
                DividerOr(),
                // I have account label
                alreadyHaveAcount(context),
                sb(27),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget alreadyHaveAcount(BuildContext context) {
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

  _register(RegisterBloc bloc, BuildContext context) {
    print("Register...");
  }
}
