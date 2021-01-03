import 'package:flutter/material.dart';

class ListTileDrawer extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTapTile;

  ListTileDrawer({
    @required this.title,
    @required this.icon,
    @required this.onTapTile,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(this.icon),
      title: Text(this.title),
      onTap: this.onTapTile,
    );
  }
}
