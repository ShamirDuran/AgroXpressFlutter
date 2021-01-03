import 'package:agroxpress/src/utils/dimens.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final onPress;

  RoundedButton({@required this.text, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: kBorderRadius,
        color: (this.onPress != null)
            ? Theme.of(context).primaryColor
            : Theme.of(context).disabledColor,
      ),
      child: FlatButton(
        child: Text(
          this.text,
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: kFontFamilyJos,
              ),
        ),
        onPressed: this.onPress,
      ),
    );
  }
}
