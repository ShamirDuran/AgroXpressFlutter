import 'package:flutter/material.dart';
import 'package:agroxpress/src/bloc/register_bloc.dart';
import 'package:agroxpress/src/providers/user_provider.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/background_poster.dart';
import 'package:agroxpress/src/widgets/divider_or.dart';
import 'package:agroxpress/src/widgets/input_field.dart';
import 'package:agroxpress/src/widgets/rounded_button.dart';
import 'package:agroxpress/src/widgets/title_expanded.dart';

class RegisterPage extends StatelessWidget {
  final _userProvider = new UserProvider();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _bloc = RegisterBloc();

    return Stack(
      children: [
        BackgroundPoster(),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return TitleExpanded(
                      title: "Registro",
                      padTop: (constraints.maxHeight <= 720)
                          ? (constraints.maxHeight <= 640)
                              //  <= 640
                              ? 0.04
                              // <= 720
                              : 0.12
                          // > 720
                          : 0.13,
                      padBottom: (constraints.maxHeight <= 820) ? 0.032 : 0.04,
                    );
                  },
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
                sb(10),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget alreadyHaveAcount(BuildContext context) {
    return GestureDetector(
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

  void _register(RegisterBloc bloc, BuildContext context) async {
    print('bloc: ${bloc.email}');
    final resp = await _userProvider.registerUser(bloc.email, bloc.password);
    (resp == true)
        ? Navigator.pushReplacementNamed(context, "home")
        : showSnackBar(resp, _scaffoldKey);
  }
}
