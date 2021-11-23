import 'package:demo/utils/url_utils.dart';

class Pokemon {
  Pokemon({
    required this.index,
    required this.name,
    required this.url,
  });
  int index;
  String name;
  String url;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    Uri url = Uri.parse(json["url"]);
    int index = int.parse(url.pathSegments[url.pathSegments.length - 2]);
    return Pokemon(
      index: index,
      name: json["name"],
      url: UrlUtils.getPokemonImageUrl(index),
    );
  }
}
