class UrlUtils {
  static String getPokemonImageUrl(int index) {
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$index.png";
  }

  static String getGenerationUrl(int index) {
    return "https://pokeapi.co/api/v2/generation/$index";
  }
}
