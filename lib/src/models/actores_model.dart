class Cast {
  List<Actor> actores = [];

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

class Actor {
  late bool adult;
  late int gender;
  late int id;
  //late Department? knownForDepartment;
  late String name;
  late String originalName;
  late double popularity;
  late String? profilePath;
  late int castId;
  late String character;
  late String creditId;
  late int order;
  late Department? department;
  late String? job;

  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    //required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    required this.department,
    required this.job,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    //knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
    department = json['department'];
    job = json['job'];
  }

  getFoto() {
    if (profilePath == null) {
      return 'https://llerena.org/wp-content/uploads/2017/11/imagen-no-disponible.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}

enum Department {
  acting,
  production,
  costume_make_up,
  directing,
  crew,
  editing,
  art,
  camera,
  lighting,
  sound,
  writing,
  visual_effects
}
