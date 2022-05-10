import 'package:flutter/material.dart';
import 'dart:math';

class FondoHomes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _fondoApp();
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
