import 'package:flutter/material.dart';

class ListTileDrawer extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTapTile;
  final Color _color = Colors.black87.withOpacity(0.75);

  ListTileDrawer({
    @required this.title,
    @required this.icon,
    @required this.onTapTile,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: this.icon != null ? Icon(this.icon, color: this._color) : null,
      title: Text(
        this.title,
        style: TextStyle(color: this._color),
      ),
      onTap: this.onTapTile,
    );
  }
}
