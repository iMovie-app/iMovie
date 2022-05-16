// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/widgets/card_swiper_widget.dart';
import 'package:peliculas_app/src/widgets/fondo_homes.dart';
import 'package:peliculas_app/src/widgets/menu_drawer.dart';

import '../providers/peliculas_provider.dart';
import '../search/search_delegate.dart';
import '../widgets/movie_horizontal.dart';

class HomeMovie extends StatelessWidget {
  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          title: Text('MOVIES',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
              },
            )
          ],
        ),

        // Propiedad del Scaffold que llama al menu que hemos creado en la clase DrawerMenu
        drawer: DrawerMenu(),
        body: Stack(children: <Widget>[
          FondoHomes(),
          Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(height: 120.0),
                  _swiperTarjetas(),
                  _footer(context),
                ],
              ),
            ),
          ),
        ]));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30.0),
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Popular',
                  style: Theme.of(context).textTheme.headline6)),
          SizedBox(height: 30.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Container(
                  height: 400.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
