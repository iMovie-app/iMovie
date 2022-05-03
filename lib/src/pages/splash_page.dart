import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/pages/home_page.dart';

class SplashPage extends StatefulWidget {
   SplashPage({Key? key}) : super(key: key);


  @override
  _SplashPageState createState() => _SplashPageState();

 }

class _SplashPageState extends State<SplashPage>{
@override
void initState() {
  super.initState();

  Timer(const Duration(seconds: 5), () =>
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage())));

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
