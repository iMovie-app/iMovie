import 'package:flutter/material.dart';

import 'dart:math';
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
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titulos(),
                SizedBox(
                  height: 20,
                ),
                _botonesRedondeados(),
              ],
            ),
          )
        ],
      ),
      drawer: DrawerMenu(),
    );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Color.fromARGB(255, 0, 0, 0),
            Color.fromARGB(255, 114, 120, 184)
          ])),
    );

    final cajaRosa = Transform.rotate(
        angle: -pi / 5.0,
        child: Container(
          height: 360.0,
          width: 360.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 37, 2, 23),
                Colors.deepPurple,
              ])),
        ));

    return Stack(
      children: <Widget>[gradiente, Positioned(top: -100.0, child: cajaRosa)],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Welcome to iMOVIE app',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
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

Widget _botonesRedondeados() {
  return Table(
    children: [
      TableRow(children: [
        _crearBotonRedondeado(Colors.blue, Icons.movie, 'Movies'),
      ]),
      TableRow(children: [
        _crearBotonRedondeado(Colors.purpleAccent, Icons.tv, 'Tv Series'),
      ]),
      TableRow(children: [
        _crearBotonRedondeado(
            Color.fromARGB(255, 34, 159, 36), Icons.contact_support, 'Contact'),
      ]),
      TableRow(children: [
        _crearBotonRedondeado(Colors.red, Icons.collections, 'Photos'),
      ])
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
