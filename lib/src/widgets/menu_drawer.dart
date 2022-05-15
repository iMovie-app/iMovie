import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(173, 37, 5, 99),
      elevation: 0,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(),
          _buildDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () => {Navigator.of(context).pushNamed('home')}),
          SizedBox(height: 10.0),
          _buildDrawerItem(
              icon: Icons.movie,
              text: 'Movies',
              onTap: () => {Navigator.of(context).pushNamed('homemovie')}),
          SizedBox(height: 10.0),
          _buildDrawerItem(
              icon: Icons.tv,
              text: 'Tv Series',
              onTap: () => {Navigator.of(context).pushNamed('hometv')}),
          SizedBox(height: 10.0),
          _buildDrawerItem(
              icon: Icons.contact_phone, text: 'Contact Info', onTap: () => {}),
          ListTile(
            title: Text('App version 1.0.0'),
            onTap: () => {Navigator.of(context).pushNamed('hometv')},
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Stack(children: <Widget>[
          Center(
            child: Image.asset(
              ("assets/img/ic_launcher.png"),
            ),
          )
        ]));
  }

  Widget _buildDrawerItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text!),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
