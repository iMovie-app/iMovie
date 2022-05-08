import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/tv_model.dart';

class MovieHorizontalSeries extends StatelessWidget {
  final List<Serie> series;
  final Function siguientePagina;

  MovieHorizontalSeries({required this.series, required this.siguientePagina});

  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.27,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: series.length,
        itemBuilder: (context, i) => _tarjeta(context, series[i]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Serie serie) {
    serie.uniqueId = '${serie.id}-poster';

    final tarjeta = Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: serie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(serie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            serie.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalleserie', arguments: serie);
      },
    );
  }

  List<Widget> _tarjetas(BuildContext context, Serie serie) {
    return series.map((pelicula) {
      final _screenSize = MediaQuery.of(context).size;
      return Container(
        margin: EdgeInsets.only(right: 10.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              serie.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}
