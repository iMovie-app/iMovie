// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/actores_model.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/pages/pelicula_detalle.dart';

class ActorDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final Actor actor = arguments['actor'];
    final Pelicula pelicula = arguments['pelicula'];
        

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(actor),
        SliverList(
            delegate: SliverChildListDelegate([
          const SizedBox(height: 10.0),
          Text("CHARACTER", textAlign: TextAlign.center),
          _character(actor),
          PeliculaDetalle().posterTitulo(context, pelicula),
          _biography(pelicula),
          
        ]))
      ],
    ));
  }

  Widget _crearAppbar(Actor actor) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.deepPurple,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          actor.name,
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(actor.getFoto()),
          placeholder: const AssetImage('assets/img/loading.gif'),
          fadeInDuration: const Duration(microseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _character(Actor actor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        actor.character,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0), fontSize: 25.0),
      ),
    );
  }

  Widget _biography(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

 
  
}
