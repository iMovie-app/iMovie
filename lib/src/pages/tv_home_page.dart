// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/providers/series_provider.dart';
import 'package:peliculas_app/src/search/search_delegate_series.dart';
import 'package:peliculas_app/src/widgets/card_swiper_widget_series.dart';
import '../search/search_delegate.dart';
import '../widgets/movie_horizontal_series.dart';

class TvHomePage extends StatelessWidget {
  final seriesProvider = SeriesProvider();

  @override
  Widget build(BuildContext context) {
    seriesProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('TV Shows'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("iMOVIE"),
              accountEmail: Text("https://github.com/iMovie-app/iMovie"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: const Text('TV Shows'),
              onTap: () {
                Navigator.of(context).pushNamed('hometv');
              },
            ),
            ListTile(
              title: const Text('Movies'),
              onTap: () {
                Navigator.of(context).pushNamed('home');
              },
            ),
          ],
        ),
      ),
    );
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
              child: Text('Populares',
                  style: Theme.of(context).textTheme.subtitle1)),
          SizedBox(height: 5.0),
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
