import 'package:flutter/material.dart';
import 'package:peliculas_app/src/pages/actor_detalle.dart';
import 'package:peliculas_app/src/pages/home_page.dart';
import 'package:peliculas_app/src/pages/splash_page.dart';

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
          'actor': (BuildContext context) => ActorDetalle(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
        ));
  }
}
