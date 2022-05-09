// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/providers/series_provider.dart';
import 'package:peliculas_app/src/search/search_delegate_series.dart';
import 'package:peliculas_app/src/widgets/card_swiper_widget_series.dart';
import 'package:peliculas_app/src/widgets/menu_drawer.dart';
import '../widgets/movie_horizontal_series.dart';
import 'dart:math';

class TvHomePage extends StatelessWidget {
  final seriesProvider = SeriesProvider();

  @override
  Widget build(BuildContext context) {
    seriesProvider.getPopulares();
    return Scaffold(
        extendBodyBehindAppBar: true,
      appBar: AppBar(
          elevation: 0,
          title: Text('TV Series',
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
                delegate: DataSearchSeries(),
              );
            },
          )
        ],
      ),

      // Propiedad del Scaffold que llama al menu que hemos creado en la clase DrawerMenu
      drawer: DrawerMenu(),
        body: Stack(children: <Widget>[
          _fondoApp(),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 70.0),
                _swiperTarjetas(),
                _footer(context),
              ],
            ),
          ),
        ]));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: seriesProvider.getOnTheAir(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CardSwiperSeries(series: snapshot.data);
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
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Popular',
                  style: Theme.of(context).textTheme.subtitle1)),
          SizedBox(height: 30.0),
          StreamBuilder(
            stream: seriesProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontalSeries(
                  series: snapshot.data,
                  siguientePagina: seriesProvider.getPopulares,
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
}
