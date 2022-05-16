// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/actores_model.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/models/tv_model.dart';
import 'package:peliculas_app/src/pages/pelicula_detalle.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';
import 'package:peliculas_app/src/widgets/card_swiper_widget.dart';

class ActorDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final Actor actor = arguments['actor'];
    final Pelicula pelicula = arguments['pelicula'];
    final Serie? serie = arguments['serie'];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 19, 19),
      body: CustomScrollView(
        slivers: <Widget>[
          PeliculaDetalle().crearAppBar(pelicula),
          SliverList(
              delegate: SliverChildListDelegate([
            const SizedBox(height: 20.0),
            _posterActor(context, actor),
            _biography(actor),
            _swiperTarjetas(context, actor.id),
            SizedBox(
              height: 20.0,
            ),
          ]))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Color.fromARGB(255, 37, 5, 99),
        backgroundColor: Color.fromARGB(225, 241, 36, 36),
        child: Icon(
          Icons.home,
        ),
        onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
        },
      ),
    );
  }

  Widget _biography(Actor actor) {
    final pelisProvider = PeliculasProvider();
    return FutureBuilder(
      future: pelisProvider.getBiography(actor.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Text(
              snapshot.data,
              textAlign: TextAlign.justify,
            ),
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
    );
  }

  Widget _swiperTarjetas(context, int actorId) {
    return Column(
      children: [
        Text('Filmography', style: Theme.of(context).textTheme.headline5),
        SizedBox(height: 20.0),
        FutureBuilder(
          future: PeliculasProvider().getPeliculasByIdActor(actorId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return CardSwiper(peliculas: snapshot.data);
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
    );
  }

  Widget _posterActor(BuildContext context, Actor actor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: actor.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(actor.getFoto()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(actor.name,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.ellipsis),
                Text(actor.character,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border, color: Colors.yellowAccent),
                    Text(actor.popularity.toString(),
                        style: Theme.of(context).textTheme.subtitle1)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
