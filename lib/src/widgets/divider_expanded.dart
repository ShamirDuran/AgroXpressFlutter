import 'package:flutter/material.dart';

class DividerExpanded extends StatelessWidget {
  const DividerExpanded({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(
        height: 30.0,
        color: Theme.of(context).accentColor,
      ),
    );
  }
}
