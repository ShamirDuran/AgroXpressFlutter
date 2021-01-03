import 'package:agroxpress/src/utils/dimens.dart';
import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/list_tile_drawer.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userPrefs = UserPref();
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Drawer profile header
            DrawerHeader(
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              "assets/images/person-placeholder.jpg"),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Hola"),
                        sb(8),
                        // TODO: Poner nombre del usuario
                        Text(
                          "Shamir Duran",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Drawer options menu
            ListTileDrawer(
              title: "Inicio",
              icon: Icons.home_outlined,
              onTapTile: () => print("home"),
            ),
            ListTileDrawer(
              title: "Buscar",
              icon: Icons.search_outlined,
              onTapTile: () => print("search"),
            ),
            ListTileDrawer(
              title: "Notificaciones",
              icon: Icons.notifications_outlined,
              onTapTile: () => print("Notificaiones"),
            ),
            ListTileDrawer(
              title: "Mis compras",
              icon: Icons.shopping_bag_outlined,
              onTapTile: () => print("Mis compras"),
            ),
            ListTileDrawer(
              title: "Favoritos",
              icon: Icons.favorite_border_outlined,
              onTapTile: () => print("Favoritos"),
            ),
            ListTileDrawer(
              title: "Mi perfil",
              icon: Icons.person_outline,
              onTapTile: () => print("Mi perfil"),
            ),
            ListTileDrawer(
              title: "Vender",
              icon: Icons.local_offer_outlined,
              onTapTile: () => print("Vender"),
            ),
            Divider(
              color: kDividerColor,
              height: kDividerHeight,
            ),
            ListTileDrawer(
              title: "Categorias",
              icon: Icons.list_outlined,
              onTapTile: () => print("Categorias"),
            ),
            ListTileDrawer(
              title: "Ayuda",
              icon: Icons.help_outline,
              onTapTile: () => print("Help"),
            ),
            Divider(
              color: kDividerColor,
              height: kDividerHeight,
            ),
            ListTileDrawer(
              title: "Cerrar sesión",
              icon: Icons.login_outlined,
              onTapTile: () {
                _userPrefs.token = "";
                Navigator.pushReplacementNamed(context, "login");
              },
            ),
            ListTileDrawer(
              title: "Acerca de nosotros",
              icon: Icons.info_outline,
              onTapTile: () => print("About us"),
            ),
            sb(30),
          ],
        ),
      ),
    );
  }
}
