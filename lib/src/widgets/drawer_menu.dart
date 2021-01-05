import 'package:agroxpress/src/utils/dimens.dart';
import 'package:agroxpress/src/utils/icons.dart';
import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/circle_image.dart';
import 'package:agroxpress/src/widgets/list_tile_drawer.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final _userPrefs = UserPref();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Drawer profile header
            DrawerHeader(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[400],
                    Colors.indigoAccent,
                  ],
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleImage(
                      width: 90,
                      height: 90,
                      imgUrl: "assets/images/person-placeholder.jpg",
                      radius: 100,
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hola",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                        sb(8),
                        // TODO: Poner nombre del usuario
                        Text(
                          "Shamir Duran",
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.white),
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
              icon: kHomeIcon,
              onTapTile: () => print("home"),
            ),
            ListTileDrawer(
              title: "Buscar",
              icon: kSearchIcon,
              onTapTile: () => print("search"),
            ),
            ListTileDrawer(
              title: "Notificaciones",
              icon: kNotificationsIcon,
              onTapTile: () => print("Notificaciones"),
            ),
            ListTileDrawer(
              title: "Mis compras",
              icon: kShoppingIcon,
              onTapTile: () => print("Mis compras"),
            ),
            ListTileDrawer(
              title: "Favoritos",
              icon: kFavoritesIcon,
              onTapTile: () => print("Favoritos"),
            ),
            ListTileDrawer(
              title: "Mi perfil",
              icon: kProfileIcon,
              onTapTile: () => Navigator.pushNamed(context, "perfil"),
            ),
            ListTileDrawer(
              title: "Vender",
              icon: kSellIcon,
              onTapTile: () => print("Vender"),
            ),
            Divider(
              color: kDividerColor,
              height: kDividerHeight,
            ),
            ListTileDrawer(
              title: "Categorias",
              icon: kCategoriesIcon,
              onTapTile: () => print("Categorias"),
            ),
            ListTileDrawer(
              title: "Ayuda",
              icon: kHelpIcon,
              onTapTile: () => print("Help"),
            ),
            Divider(
              color: kDividerColor,
              height: kDividerHeight,
            ),
            ListTileDrawer(
              title: "Cerrar sesión",
              icon: kLogoutIcon,
              onTapTile: () => showLogOutDialog(context, _userPrefs),
            ),
            ListTileDrawer(
              title: "Acerca de nosotros",
              icon: kAboutusIcon,
              onTapTile: () => print("About us"),
            ),
            sb(30),
          ],
        ),
      ),
    );
  }
}
