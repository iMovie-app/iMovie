class Cast {
  List<Actor> items = [];

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      items.add(actor);
    });
  }
}

class Actor {
  late int id;
  late String name;
  late String originalName;
  late double popularity;
  late String? profilePath;
  late int castId;
  late String character;
  late String creditId;

  Actor({
    required this.id,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
  }

  
  getFoto() {
    if (profilePath == null) {
      return 'https://llerena.org/wp-content/uploads/2017/11/imagen-no-disponible.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
