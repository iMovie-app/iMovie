// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../models/actores_model.dart';
import '../models/tv_model.dart';
import '../providers/series_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SerieDetalle extends StatelessWidget {
  final seriesProvider = SeriesProvider();
  @override
  Widget build(BuildContext context) {
    final Serie serie = ModalRoute.of(context)!.settings.arguments as Serie;
    final seriesProvider = SeriesProvider();

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 19, 19, 19),
        body: CustomScrollView(
          slivers: <Widget>[
            crearAppBar(serie),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 10.0,
                ),
                posterTitulo(context, serie),
                _descripcion(serie),
                _youtubeTrailer(context, serie),
                _crearCasting(serie),
                _similarMovies(serie),
              ]),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Color.fromARGB(255, 37, 5, 99),
          backgroundColor: Color.fromARGB(225, 241, 36, 36),
          child: Icon(
            Icons.home,
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                'home', (Route<dynamic> route) => false);
          },
        ));
  }

  Widget crearAppBar(Serie serie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.transparent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(serie.name,
            style: TextStyle(color: Colors.white, fontSize: 16.0)),
        background: Image(
          image: NetworkImage(serie.getBackgroundImg()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget posterTitulo(BuildContext context, Serie serie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: serie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(serie.getPosterImg()),
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
                Text(serie.name,
                    style: Theme.of(context).textTheme.headline5,
                    overflow: TextOverflow.ellipsis),
                Text(serie.numberOfSeasons.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border, color: Colors.yellowAccent),
                    Text(serie.voteAverage.toString(),
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

  Widget _descripcion(Serie serie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        serie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Serie serie) {
    return FutureBuilder(
      future: seriesProvider.getCast(serie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data, serie);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores, Serie serie) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(context, actores[i], serie),
      ),
    );
  }

  //Método para crear la tarjeta de los actores con sus fotos
  Widget _actorTarjeta(BuildContext context, Actor actor, Serie serie) {
    final tarjeta = Column(
      children: <Widget>[
        Tooltip(
          message: actor.character,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(actor.getFoto()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          actor.name,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed('actorserie', arguments: {
          'serie': serie,
          'actor': actor,
        });
      },
    );
  }

  Widget _youtubeTrailer(BuildContext context, Serie serie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Trailer',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          FutureBuilder(
            future: seriesProvider.buscarTrailer(serie.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: snapshot.data,
                      flags: YoutubePlayerFlags(
                        autoPlay: false,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.blueAccent,
                    progressColors: ProgressBarColors(
                      playedColor: Colors.amber,
                      handleColor: Colors.amberAccent,
                    ),
                  ),
                  builder: (context, player) => player,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  //Similar movies
  Widget _similarMovies(Serie serie) {
    return FutureBuilder(
      future: seriesProvider.getSimilarSeries(serie.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _crearSimilarPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearSimilarPageView(List<Serie> series) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: series.length,
        itemBuilder: (context, i) => _similarTarjeta(context, series[i]),
      ),
    );
  }

  Widget _similarTarjeta(BuildContext context, Serie serie) {
    serie.uniqueId = '${serie.id}-similar';

    final tarjeta = Column(
      children: <Widget>[
        Tooltip(
          message: serie.name,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(serie.getPosterImg()),
              placeholder: const AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          serie.name,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalleserie', arguments: serie);
      },
    );
  }
}
