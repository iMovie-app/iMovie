import 'package:flutter/material.dart';
import 'package:peliculas_app/src/pages/actor_detalle.dart';
import 'package:peliculas_app/src/pages/actor_detalle_series.dart';
import 'package:peliculas_app/src/pages/contact.dart';
import 'package:peliculas_app/src/pages/home.dart';
import 'package:peliculas_app/src/pages/home_movie.dart';
import 'package:peliculas_app/src/pages/serie_detalle.dart';
import 'package:peliculas_app/src/pages/splash_page.dart';
import 'package:peliculas_app/src/pages/home_tv.dart';

import 'src/pages/pelicula_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'splash': (BuildContext context) => SplashPage(),
          'home': (BuildContext context) => Home(),
          'homemovie': (BuildContext context) => HomeMovie(),
          'hometv': (BuildContext context) => TvHomePage(),
        'contact': (BuildContext context) => Contact(),
          'detalle': (BuildContext context) => PeliculaDetalle(),
          'detalleserie': (BuildContext context) => SerieDetalle(),
          'actor': (BuildContext context) => ActorDetalle(),
        'actorserie': (BuildContext context) => ActorDetalleSerie(),
        },
        theme: ThemeData(
        // Define el Brightness y Colores por defecto
          brightness: Brightness.dark,

      ),
    );
  }
}
