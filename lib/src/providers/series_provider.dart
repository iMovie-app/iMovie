// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'dart:convert';
import 'package:peliculas_app/src/models/tv_model.dart';
import '../models/actores_model.dart';
import 'package:http/http.dart' as http;

import '../models/video_model.dart';

class SeriesProvider {
  String _apikey = '8f0c5d6e504bebd18c29c2c3535cec9d';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  String _language2 = 'en-US';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Serie> _populares = [];

  final _popularesStreamController = StreamController<List<Serie>>.broadcast();

  Function(List<Serie>) get popularesSink =>
      _popularesStreamController.sink.add;
  Stream<List<Serie>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController.close();
  }

  Future<List<Serie>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final series = Series.fromJsonList(decodedData['results']);

    return series.items;
  }

  Future<List<Serie>> _procesarRespuesta2(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final series = Series.fromJsonList(decodedData['cast']);

    return series.items;
  }

  Future<List<Serie>> getOnTheAir() async {
    final url = Uri.https(_url, '/3/tv/on_the_air', {
      'api_key': _apikey,
      'language': _language2,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Serie>> getSimilarSeries(int id) async {
    final url = Uri.https(_url, '/3/tv/$id/similar', {
      'api_key': _apikey,
      'language': _language2,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Serie>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '/3/tv/popular', {
      'api_key': _apikey,
      'language': _language2,
      'page': _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String serieId) async {
    final url = Uri.https(_url, '/3/tv/$serieId/credits', {
      'api_key': _apikey,
      'language': _language2,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = Cast.fromJsonList(decodedData['cast']);

    return cast.items;
  }

  Future<List<Serie>> buscarSerie(String query) async {
    final url = Uri.https(_url, '/3/search/tv', {
      'api_key': _apikey,
      'language': _language2,
      'query': query,
    });

    return await _procesarRespuesta(url);
  }

  // Trailers providers

  Future<dynamic> buscarTrailer(int serieID) async {
    final url = Uri.https(_url, '/3/tv/$serieID/videos', {
      'api_key': _apikey,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final trailers = Trailers.fromJsonList(decodedData['results']);
    String? key = trailers.getTrailer();

    return key;
  }

//Método que retorna un listado de películas en las que participa
//el ID de actor pasado por parámetro.
  Future<List<Serie>> getPeliculasByIdActor(int actorId) async {
    final url = Uri.https(_url, '3/person/$actorId/tv_credits', {
      'api_key': _apikey,
      'language': _language2,
    });

    return await _procesarRespuesta2(url);
  }

//Método que retorna la biografía de un actor a partir de su Id
  Future<String> getBiography(int actorId) async {
    final url = Uri.https(_url, '3/person/$actorId', {
      'api_key': _apikey,
      'language': _language2,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    String biography = decodedData['biography'];

    return biography;
  }
}
