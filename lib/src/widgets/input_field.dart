import 'package:agroxpress/src/utils/dimens.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final bool password;
  final IconData icon;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final String error;
  final changeValue;

  final kTextStyle = TextStyle(
    fontSize: 18,
    fontFamily: kFontFamilyJos,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );

  final kErrorStyle = TextStyle(
    fontSize: 17.0,
    fontFamily: kFontFamilyJos,
    color: Color(0xFFff7675),
  );

  InputField({
    @required this.hintText,
    @required this.password,
    @required this.icon,
    @required this.inputType,
    @required this.inputAction,
    @required this.error,
    @required this.changeValue,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        obscureText: this.password,
        textAlignVertical: TextAlignVertical.bottom,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: kBorderRadius),
          errorText: this.error,
          errorStyle: this.kErrorStyle,
          filled: true,
          fillColor: Colors.grey[500].withOpacity(0.5),
          focusedBorder: OutlineInputBorder(
            borderRadius: kBorderRadius,
            borderSide: BorderSide(color: Theme.of(context).accentColor),
          ),
          labelText: this.hintText,
          labelStyle: this.kTextStyle,
          hintStyle: TextStyle(
            fontFamily: kFontFamilyJos,
          ),
          prefixIcon: Icon(
            this.icon,
            color: Colors.white,
            size: 26.0,
          ),
        ),
        keyboardType: this.inputType,
        textInputAction: this.inputAction,
        style: this.kTextStyle,
        onChanged: this.changeValue,
      ),
    );
  }
}
