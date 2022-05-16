// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/providers/series_provider.dart';
import 'package:peliculas_app/src/search/search_delegate_series.dart';
import 'package:peliculas_app/src/widgets/card_swiper_widget_series.dart';
import 'package:peliculas_app/src/widgets/fondo_homes.dart';
import 'package:peliculas_app/src/widgets/menu_drawer.dart';
import '../widgets/movie_horizontal_series.dart';

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
          FondoHomes(),
          Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    height: 120.0,
                  ),
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
          SizedBox(
            height: 20.0,
          ),
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Popular',
                  style: Theme.of(context).textTheme.headline5)),
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
}
