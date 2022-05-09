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
            onTap: () {},
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
          CircleAvatar(
            backgroundColor: Colors.deepPurple,
            radius: 120.0,
            child: Icon(Icons.abc, color: Colors.white, size: 30.0),
            backgroundImage: AssetImage("assets/img/iMovie.jpeg"),
          ),
          Positioned(
              bottom: 20.0,
              left: 20.0,
              child: Text("",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500))),
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
