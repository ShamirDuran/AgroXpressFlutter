import 'package:agroxpress/src/models/user_model.dart';
import 'package:agroxpress/src/providers/user_provider.dart';
import 'package:agroxpress/src/utils/icons.dart';
import 'package:agroxpress/src/utils/styles.dart';
import 'package:agroxpress/src/utils/user_prefs.dart';
import 'package:agroxpress/src/utils/utils.dart';
import 'package:agroxpress/src/widgets/circle_image.dart';
import 'package:flutter/material.dart';

// Actions menu
final List<Map<String, dynamic>> actionsList = [
  {
    "title": "Mis compras",
    "icon": kShoppingIconFilled,
    "action": "Mis compras",
  },
  {
    "title": "Mis ventas",
    "icon": kSellIconFilled,
    "action": "Mis ventas",
  },
  {
    "title": "Mis Publicaciones",
    "icon": kPublicationsIconFilled,
    "action": "my-publications",
  },
];

// Configuration account menu
final List<Map<String, dynamic>> confAccount = [
  {
    "title": "Mi información",
    "icon": kProfileIconFilled,
    "action": "Seguridad",
  },
  {
    "title": "Seguridad",
    "icon": kSecurityIconFilled,
    "action": "Seguridad",
  },
  {
    "title": "Ayuda",
    "icon": kHelpIconFilled,
    "action": "Ayuda",
  },
  {
    "title": "Cerrar sesión",
    "icon": kLogoutIconFilled,
    "action": "",
  },
];

class PerfilPage extends StatelessWidget {
  final _userProvider = new UserProvider();
  final _prefs = new UserPref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: FutureBuilder(
        future: _userProvider.getUserData(_prefs.id),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.hasData)
            return BuildBody(snapshot.data);
          else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // Appbar for this page
  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        "Mi perfil",
        style: TextStyle(
          fontWeight: kAppbarTitles,
        ),
      ),
    );
  }
}

class BuildBody extends StatefulWidget {
  final UserModel user;
  BuildBody(this.user);

  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  final _prefs = UserPref();

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            sb(25),
            CircleImage(
              width: 110,
              height: 110,
              imgUrl: widget.user.img ?? "",
              radius: 100,
            ),
            sb(4),
            _nameheader(context),
            sb(3),
            _ubicationHeader(context),
            sb(20),
            _actionsHeader(),
            sb(10),
            Divider(height: 1.0, color: Colors.grey),
            sb(15),
            _actionsConfTitle(context),
            sb(12),
            _actionsConf(),
            sb(20),
          ],
        ),
      ),
    );
  }

  // User name
  Text _nameheader(BuildContext context) {
    return Text(
      widget.user.name,
      style: Theme.of(context).textTheme.headline6.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
    );
  }

  // User ubication
  Text _ubicationHeader(BuildContext context) {
    return Text(
      // TODO:: poner direccion desde el back
      "Bucaramanga, Santander",
      style: Theme.of(context).textTheme.caption.copyWith(
            fontSize: 14.4,
            fontWeight: FontWeight.w300,
          ),
    );
  }

  // Menu de acciones para el usuario
  Widget _actionsHeader() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: actionsList.length,
      itemBuilder: (BuildContext context, int index) =>
          _listTile(actionsList[index]),
    );
  }

  Container _actionsConfTitle(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        "Configuración de la cuenta",
        style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 15.5,
            color: Colors.grey[600]),
      ),
    );
  }

  // Actions for configuration account
  Widget _actionsConf() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: confAccount.length,
      itemBuilder: (BuildContext context, int index) =>
          _listTile(confAccount[index]),
    );
  }

  Widget _listTile(Map<String, dynamic> action) {
    return ListTile(
      title: Text(
        action["title"],
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0),
      ),
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          action["icon"],
          color: Colors.white,
          size: 20.0,
        ),
      ),
      onTap: () => (action["title"] == "Cerrar sesión")
          ? showLogOutDialog(context, _prefs)
          : Navigator.pushNamed(context, action["action"]),
    );
  }
}
