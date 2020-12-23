import 'package:agroxpress/src/utils/dimens.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;

  RoundedButton({@required this.text});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      height: 63,
      decoration: BoxDecoration(
        borderRadius: kBorderRadius,
        color: Theme.of(context).primaryColor,
      ),
      child: FlatButton(
        child: Text(
          this.text,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {},
      ),
    );
  }
}
