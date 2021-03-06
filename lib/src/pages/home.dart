// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/widgets/fondo_homes.dart';

import 'dart:ui';
import 'package:peliculas_app/src/widgets/menu_drawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
          FondoHomes(),
          CustomScrollView(
            slivers: <Widget>[
              _titulos(),
              SliverList(
                delegate:
                    SliverChildListDelegate([_botonesRedondeados(context)]),
              )
            ],
          ),
        ]),
        drawer: DrawerMenu());
  }

Widget _titulos() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 230.0,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Image(
            image: AssetImage("assets/img/iMOVIE_logo(500x250).png"),
            fit: BoxFit.fill,
          ),
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
          child:
              _crearBotonRedondeado(Colors.blue, "assets/img/buttonMovies.png"),
          onTap: () => {Navigator.of(context).pushNamed('homemovie')},
        ),
      ]),
      TableRow(children: [
        GestureDetector(
          child: _crearBotonRedondeado(
              Colors.purpleAccent, "assets/img/buttonSeries.png"),
          onTap: () => {Navigator.of(context).pushNamed('hometv')},
        ),
      ]),
      TableRow(children: [
        GestureDetector(
          child: _crearBotonRedondeado(
              Color.fromARGB(255, 34, 159, 36), "assets/img/buttonContact.png"),
          onTap: () => {Navigator.of(context).pushNamed('contact')},
        ),
      ]),
    ],
  );
}

Widget _crearBotonRedondeado(Color color, String srcImage) {
  return ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        height: 120.0,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
                image: AssetImage(srcImage), fit: BoxFit.cover)),
      ),
    ),
  );
}
