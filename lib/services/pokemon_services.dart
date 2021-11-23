import 'dart:convert';

import 'package:demo/models/core/generation.dart';
import 'package:demo/utils/url_utils.dart';
import 'package:http/http.dart' as http;

class PokemonServices {
  static Future<Generation> getGeneration(int index) async {
    Uri url = Uri.parse(UrlUtils.getGenerationUrl(index));
    var response = await http.get(url);
    return Generation.fromJson(json.decode(response.body));
  }
}
