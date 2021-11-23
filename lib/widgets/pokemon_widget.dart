import 'package:demo/models/core/pokemon.dart';
import 'package:demo/utils/string_utils.dart';
import 'package:flutter/material.dart';

class PokemonWidget extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonWidget(this.pokemon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        pokemon.url,
        filterQuality: FilterQuality.high,
      ),
      title: Text(pokemon.name.capitalize()),
    );
  }
}
