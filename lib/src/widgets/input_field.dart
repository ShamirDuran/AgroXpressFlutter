import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final bool password;
  final IconData icon;
  final TextInputType inputType;
  final TextInputAction inputAction;

  InputField(
      {@required this.hintText,
      @required this.password,
      @required this.icon,
      @required this.inputType,
      @required this.inputAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.grey[500].withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          obscureText: password,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(icon, size: 34.0, color: Colors.white),
            ),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 22, color: Colors.white),
          ),
          style: TextStyle(fontSize: 22, color: Colors.white),
          keyboardType: inputType,
          textInputAction: inputAction,
        ),
      ),
    );
  }
}
