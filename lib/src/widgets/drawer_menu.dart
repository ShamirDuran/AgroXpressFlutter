import 'package:agroxpress/src/search/search_delegate.dart';
import 'package:agroxpress/src/utils/dimens.dart';
import 'package:agroxpress/src/utils/icons.dart';
import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/circle_image.dart';
import 'package:agroxpress/src/widgets/list_tile_drawer.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final _prefs = UserPref();

  @override
  Widget build(BuildContext context) {
    final _name = _prefs.name;
    final _image = _prefs.image != ""
        ? _prefs.image
        : "assets/images/person-placeholder.jpg";

    return Drawer(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: SingleChildScrollView(
          child: _prefs.token != ""
              ? _headerLogued(_image, _name, context)
              : _headerSimple(_image, _name, context),
        ),
      ),
    );
  }

  Widget _headerSimple(_image, _name, BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 20.0,
                  right: 15.0,
                  bottom: 10.0,
                ),
                child: Text(
                  "AgroXpress",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: "Pacifico",
                    fontSize: 30.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Inicia sesión para acceder a más opciones.",
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          sb(10),
          ListTileDrawer(
            title: "Iniciar sesión",
            icon: Icons.login_outlined,
            onTapTile: () => Navigator.pushNamed(context, "login"),
          ),
          ListTileDrawer(
            title: "Registrarse",
            icon: kProfileIcon,
            onTapTile: () => Navigator.pushNamed(context, "register"),
          ),
          Divider(
            color: kDividerColor,
            height: kDividerHeight,
          ),

          // Drawer options menu
          _optInicio(),
          _optBuscar(context),
          Divider(
            color: kDividerColor,
            height: kDividerHeight,
          ),
          _optCategorias(context),
          _optAyuda(),
          Divider(
            color: kDividerColor,
            height: kDividerHeight,
          ),
          _optAboutUs(),
          sb(30),
        ],
      ),
    );
  }

  Widget _headerLogued(_image, _name, BuildContext context) {
    return Column(
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
                  imgUrl: _image,
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
                    Text(
                      _name,
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
        _optInicio(),
        _optBuscar(context),
        _optNotificaciones(context),
        _optCompras(context),
        _optFavoritos(context),
        _optPerfil(context),
        _optVender(context),
        Divider(
          color: kDividerColor,
          height: kDividerHeight,
        ),
        _optCategorias(context),
        _optAyuda(),
        Divider(
          color: kDividerColor,
          height: kDividerHeight,
        ),
        _optCerrarSesion(context),
        _optAboutUs(),
        sb(30),
      ],
    );
  }

  ListTileDrawer _optAboutUs() {
    return ListTileDrawer(
      title: "Acerca de nosotros",
      icon: kAboutusIcon,
      onTapTile: () => print("About us"),
    );
  }

  ListTileDrawer _optCerrarSesion(BuildContext context) {
    return ListTileDrawer(
      title: "Cerrar sesión",
      icon: kLogoutIcon,
      onTapTile: () => showLogOutDialog(context, _prefs),
    );
  }

  ListTileDrawer _optAyuda() {
    return ListTileDrawer(
      title: "Ayuda",
      icon: kHelpIcon,
      onTapTile: () => print("Help"),
    );
  }

  ListTileDrawer _optCategorias(BuildContext context) {
    return ListTileDrawer(
      title: "Categorias",
      icon: kCategoriesIcon,
      onTapTile: () => Navigator.pushNamed(context, "categories"),
    );
  }

  ListTileDrawer _optVender(BuildContext context) {
    return ListTileDrawer(
      title: "Vender",
      icon: kSellIcon,
      onTapTile: () => Navigator.pushNamed(context, "create-publication"),
    );
  }

  ListTileDrawer _optPerfil(BuildContext context) {
    return ListTileDrawer(
      title: "Mi perfil",
      icon: kProfileIcon,
      onTapTile: () =>
          Navigator.pushNamed(context, "perfil", arguments: _prefs),
    );
  }

  ListTileDrawer _optFavoritos(BuildContext context) {
    return ListTileDrawer(
      title: "Favoritos",
      icon: kFavoritesIcon,
      onTapTile: () => Navigator.pushNamed(context, "favorites"),
    );
  }

  ListTileDrawer _optCompras(BuildContext context) {
    return ListTileDrawer(
      title: "Mis compras",
      icon: kShoppingIcon,
      onTapTile: () => Navigator.pushNamed(context, "shopping"),
    );
  }

  ListTileDrawer _optNotificaciones(BuildContext context) {
    return ListTileDrawer(
      title: "Notificaciones",
      icon: kNotificationsIcon,
      onTapTile: () => Navigator.pushNamed(context, "notifications"),
    );
  }

  ListTileDrawer _optBuscar(BuildContext context) {
    return ListTileDrawer(
      title: "Buscar",
      icon: kSearchIcon,
      onTapTile: () => showSearch(context: context, delegate: DataSearch()),
    );
  }

  ListTileDrawer _optInicio() {
    return ListTileDrawer(
      title: "Inicio",
      icon: kHomeIcon,
      onTapTile: () => print("home"),
    );
  }
}
