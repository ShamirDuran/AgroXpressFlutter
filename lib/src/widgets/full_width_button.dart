import 'package:flutter/material.dart';

class FullWidthButton extends StatelessWidget {
  final Function clickHandler;
  final String title;

  FullWidthButton({@required this.clickHandler, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: this.clickHandler,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            this.title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 17.0),
          ),
        ),
      ),
    );
  }
}
