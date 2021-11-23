// To parse this JSON data, do
//
//     final generation = generationFromJson(jsonString);

import 'package:demo/models/core/pokemon.dart';
import 'dart:convert';

Generation generationFromJson(String str) =>
    Generation.fromJson(json.decode(str));

class Generation {
  Generation({
    required this.id,
    required this.pokemonSpecies,
  });

  int id;
  List<Pokemon> pokemonSpecies;

  factory Generation.fromJson(Map<String, dynamic> json) {
    return Generation(
      id: json["id"],
      pokemonSpecies: List<Pokemon>.from(
          json["pokemon_species"].map((x) => Pokemon.fromJson(x))),
    )..pokemonSpecies.sort((a, b) {
        return a.index.compareTo(b.index);
      });
  }
}
