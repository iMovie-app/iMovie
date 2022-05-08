// ignore_for_file: unnecessary_null_comparison

class Series {
  List<Serie> items = [];

  Series.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final serie = Serie.fromJsonMap(item);
      items.add(serie);
    }
  }
}

class Serie {
  late String uniqueId;
  late String? backdropPath;
  late List<int> genreIds;
  late int id;
  late String name;
  late List<String> originCountry;
  late String originalLanguage;
  late String originalName;
  late String overview;
  late double popularity;
  late String? posterPath;
  late double voteAverage;

  Serie({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
  });

  Serie.fromJsonMap(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    id = json['id'];
    name = json['name'];
    originalLanguage = json['original_language'];
    originalName = json['original_name'];
    overview = json['overview'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    voteAverage = json['vote_average'] / 1;
  }

  getPosterImg() {
    if (posterPath == null) {
      return 'https://llerena.org/wp-content/uploads/2017/11/imagen-no-disponible.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w400/$posterPath';
    }
  }

  getBackgroundImg() {
    if (backdropPath == null) {
      if (posterPath == null) {
        return 'https://llerena.org/wp-content/uploads/2017/11/imagen-no-disponible.jpg';
      } else {
        return 'https://image.tmdb.org/t/p/w400/$posterPath';
      }
    } else {
      return 'https://image.tmdb.org/t/p/w400/$backdropPath';
    }
  }
}
