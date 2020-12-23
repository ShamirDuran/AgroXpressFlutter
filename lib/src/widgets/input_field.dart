import 'package:agroxpress/src/utils/dimens.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final bool password;
  final IconData icon;
  final TextInputType inputType;
  final TextInputAction inputAction;

  final kTextStyle = TextStyle(fontSize: 22, color: Colors.white);

  InputField(
      {@required this.hintText,
      @required this.password,
      @required this.icon,
      @required this.inputType,
      @required this.inputAction});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: 80.0,
      width: size.width * 0.8,
      child: TextFormField(
        obscureText: this.password,
        textAlignVertical: TextAlignVertical.bottom,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          filled: true,
          errorStyle: TextStyle(fontSize: 17.0),
          fillColor: Colors.grey[500].withOpacity(0.5),
          border: OutlineInputBorder(borderRadius: kBorderRadius),
          focusedBorder: OutlineInputBorder(
            borderRadius: kBorderRadius,
            borderSide: BorderSide(color: Theme.of(context).accentColor),
          ),
          labelText: this.hintText,
          labelStyle: this.kTextStyle,
          prefixIcon: Icon(
            this.icon,
            color: Colors.white,
            size: 26.0,
          ),
        ),
        keyboardType: this.inputType,
        textInputAction: this.inputAction,
        style: this.kTextStyle,
      ),
    );
  }
}
