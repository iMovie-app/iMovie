// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/pages/home.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(milliseconds: 6200),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 24, 24),
        body: Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/iMOVIE_gif_splash2.gif"),
                fit: BoxFit.fitWidth,
              ),
            ))
          ],
        ));
  }
}
