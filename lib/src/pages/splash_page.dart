import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/pages/home.dart';
import 'package:peliculas_app/src/pages/home_movie.dart';

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();

 }

class _SplashPageState extends State<SplashPage>{
@override
void initState() {
  super.initState();

  Timer(const Duration(seconds: 4), () =>
      Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home())));

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image:DecorationImage(
                image:AssetImage("assets/img/iMovie.jpeg"),
                fit: BoxFit.cover,
              ),
            )
          )
        ],
      )
    );
  }

  }
