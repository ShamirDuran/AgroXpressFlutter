import 'package:flutter/material.dart';

class PriceBadge extends StatelessWidget {
  final String text;
  final double size, radius, pVer, pHor;
  final FontWeight weight;

  PriceBadge({
    @required this.text,
    @required this.size,
    @required this.radius,
    this.pVer = 2.0,
    this.pHor = 6.5,
    this.weight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(vertical: this.pVer, horizontal: this.pHor),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(this.radius),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              this.text,
              style: TextStyle(
                fontSize: this.size,
                fontWeight: this.weight,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
