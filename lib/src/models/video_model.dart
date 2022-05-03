// ignore_for_file: unnecessary_null_comparison

class Trailers {
  List<Trailer> items = [];

  Trailers({required this.items});

  Trailers.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final trailer = Trailer.fromJsonMap(item);
      items.add(trailer);
    }
  }
  getTrailer() {
    if (items != null) {
      for (var item in items) {
        if (item.type == 'Trailer') {
          return item.key.toString();
        }
      }
    } else {
      return '4wCH1K-ckZw';
    }
  }
}

class Trailer {
  late String? key;
  late String? type;
  late bool? official;
  late String? id;

  Trailer({
    required this.key,
    required this.type,
    required this.official,
    required this.id,
  });

  Trailer.fromJsonMap(Map<String, dynamic> json) {
    key = json["key"];
    type = json["type"];
    official = json["official"];
    id = json["id"];
  }
}
