import 'package:flutter/material.dart';
import 'package:agroxpress/src/bloc/login_bloc.dart';
import 'package:agroxpress/src/providers/user_provider.dart';
import 'package:agroxpress/src/widgets/divider_or.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/background_poster.dart';
import 'package:agroxpress/src/widgets/input_field.dart';
import 'package:agroxpress/src/widgets/rounded_button.dart';
import 'package:agroxpress/src/widgets/title_expanded.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userProvider = UserProvider();
  final _bloc = LoginBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundPoster(),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Title agroxpress
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return TitleExpanded(
                      title: "AgroXpress",
                      padTop: (constraints.maxHeight <= 720)
                          ? (constraints.maxHeight <= 640)
                              // <= 640
                              ? 0.10
                              // <= 720
                              : 0.14
                          // > 720
                          : 0.16,
                      padBottom: (constraints.maxHeight <= 720)
                          ? (constraints.maxHeight <= 640)
                              // <= 640
                              ? 0.04
                              // <= 720
                              : 0.09
                          // > 720
                          : 0.14,
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
                sb(10.0),
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
                sb(10.0)
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
      child: Text(
        "¿Olvidaste tu contraseña?",
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              color: Colors.white,
              fontFamily: kFontFamilyJos,
            ),
      ),
    );
  }

  Widget crearNuevaCuenta(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacementNamed(context, "register"),
      child: Container(
        padding: EdgeInsets.only(bottom: 5.0),
        child: Text(
          "Crear nueva cuenta",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
                fontFamily: kFontFamilyJos,
                fontSize: 18.0,
              ),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _login(LoginBloc bloc, BuildContext context) async {
    final resp = await _userProvider.loginUser(bloc.email, bloc.password);
    resp
        ? Navigator.pushNamedAndRemoveUntil(context, "home", (r) => false)
        : showSnackBar("Correo o contraseña incorrecta", _scaffoldKey);
  }
}
