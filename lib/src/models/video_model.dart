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
    int flag = 0;
    if (items != null) {
      for (var item in items) {
        if (item.type == 'Trailer' && item.site == 'YouTube') {
          flag = 1;
          return item.key.toString();
        }
      }
    }
    if (flag == 0) {
      for (var item2 in items) {
        if (item2.type == 'Teaser' && item2.site == 'YouTube') {
          return item2.key.toString();
        }
      }
    } else {
      return null;
    }
  }
}

class Trailer {
  late String? key;
  late String? type;
  late bool? official;
  late String? id;
  late String? site;

  Trailer({
    required this.key,
    required this.type,
    required this.official,
    required this.id,
    required this.site,
  });

  Trailer.fromJsonMap(Map<String, dynamic> json) {
    key = json["key"];
    type = json["type"];
    official = json["official"];
    id = json["id"];
    site = json["site"];
  }
}
