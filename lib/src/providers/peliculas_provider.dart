// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'dart:convert';

import '../models/actores_model.dart';
import '../models/pelicula_model.dart';
import 'package:http/http.dart' as http;

import '../models/video_model.dart';

class PeliculasProvider {
  String _apikey = '8f0c5d6e504bebd18c29c2c3535cec9d';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';
  String _language2 = 'en-US';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = [];

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> _procesarRespuesta2(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = Peliculas.fromJsonList(decodedData['cast']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getSimilarMovies(int id) async {
    final url = Uri.https(_url, '/3/movie/$id/similar', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;

    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString(),
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '/3/movie/$peliId/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = Cast.fromJsonList(decodedData['cast']);

    return cast.items;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '/3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query,
    });

    return await _procesarRespuesta(url);
  }

  // Trailers providers

  Future<dynamic> buscarTrailer(int movieID) async {
    final url = Uri.https(_url, '/3/movie/$movieID/videos', {
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
  Future<List<Pelicula>> getPeliculasByIdActor(int actorId) async {
    final url = Uri.https(_url, '3/person/$actorId/movie_credits', {
      'api_key': _apikey,
      'language': _language,
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
