// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/tv_model.dart';
import '../providers/series_provider.dart';

class DataSearchSeries extends SearchDelegate {
  String seleccion = '';
  final seriesProvider = SeriesProvider();

  final series = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Capitan America',
    'Ironman 2',
    'Ironman 3',
    'Ironman 4',
    'Ironman 5',
  ];

  final seriesRecientes = ['Spiderman', 'Capitan America', 'Ironman'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.deepPurple,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando escriben

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: seriesProvider.buscarSerie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Serie>> snapshot) {
        if (snapshot.hasData) {
          final series = snapshot.data;
          return ListView(
            children: series!.map((serie) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(serie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(serie.name),
                subtitle: Text(serie.originalName),
                onTap: () {
                  close(context, null);
                  serie.uniqueId = '';
                  Navigator.pushNamed(context, 'detalleserie',
                      arguments: serie);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
