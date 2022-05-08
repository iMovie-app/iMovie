import 'package:flutter/material.dart';
import 'package:peliculas_app/src/pages/actor_detalle.dart';
import 'package:peliculas_app/src/pages/actor_detalle_series.dart';
import 'package:peliculas_app/src/pages/home_page.dart';
import 'package:peliculas_app/src/pages/serie_detalle.dart';
import 'package:peliculas_app/src/pages/splash_page.dart';
import 'package:peliculas_app/src/pages/tv_home_page.dart';

import 'src/pages/pelicula_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash',
        routes: {
          'splash': (BuildContext context) => SplashPage(),
          'home': (BuildContext context) => HomePage(),
          'detalle': (BuildContext context) => PeliculaDetalle(),
          'detalleserie': (BuildContext context) => SerieDetalle(),
          'actor': (BuildContext context) => ActorDetalle(),
          'actorserie': (BuildContext context) => ActorDetalleSerie(),
          'hometv': (BuildContext context) => TvHomePage(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
        ));
  }
}
