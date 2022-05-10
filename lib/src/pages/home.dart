import 'package:flutter/material.dart';
import 'package:peliculas_app/src/widgets/fondo_homes.dart';

import 'dart:ui';
import 'package:peliculas_app/src/widgets/menu_drawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          FondoHomes(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titulos(),
                SizedBox(
                  height: 30,
                ),
                _botonesRedondeados(context),
              ],
            ),
          )
        ],
      ),
      drawer: DrawerMenu(),
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('iMOVIE app',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Text('Find information about movies and TV series ',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}

Widget _botonesRedondeados(BuildContext context) {
  return Table(
    children: [
      TableRow(children: [
        GestureDetector(
          child: _crearBotonRedondeado(Colors.blue, Icons.movie, 'Movies'),
          onTap: () => {Navigator.of(context).pushNamed('homemovie')},
        ),
        GestureDetector(
          child: _crearBotonRedondeado(Colors.blue, Icons.movie, 'Movies'),
          onTap: () => {Navigator.of(context).pushNamed('homemovie')},
        ),
      ]),
      TableRow(children: [
        GestureDetector(
          child:
              _crearBotonRedondeado(Colors.purpleAccent, Icons.tv, 'Tv Series'),
          onTap: () => {Navigator.of(context).pushNamed('hometv')},
        ),
        GestureDetector(
          child: _crearBotonRedondeado(Colors.blue, Icons.movie, 'Movies'),
          onTap: () => {Navigator.of(context).pushNamed('homemovie')},
        ),
      ]),
      TableRow(children: [
        GestureDetector(
          child: _crearBotonRedondeado(Color.fromARGB(255, 34, 159, 36),
              Icons.contact_support, 'Contact'),
          onTap: () => {},
        ),
        GestureDetector(
          child: _crearBotonRedondeado(Colors.blue, Icons.movie, 'Movies'),
          onTap: () => {Navigator.of(context).pushNamed('homemovie')},
        ),
      ]),
    ],
  );
}

Widget _crearBotonRedondeado(Color color, IconData icono, String texto) {
  return ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        height: 180.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 5.0),
            CircleAvatar(
              backgroundColor: color,
              radius: 50.0,
              child: Icon(icono, color: Colors.white, size: 40.0),
            ),
            Text(texto, style: TextStyle(color: color)),
            SizedBox(height: 5.0)
          ],
        ),
      ),
    ),
  );
}
