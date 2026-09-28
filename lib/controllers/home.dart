import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/pokemon.dart';

class HomeController {
  final PokemonService pokemonService;

  HomeController({
    required this.pokemonService,
  });

  Future<Pokemon> getPokemonOfTheDay() {
    final today = DateTime.now();
    final firstDayOfTheYear = DateTime(today.year, 1, 1);

    final pokemonId =
        today.difference(firstDayOfTheYear).inDays + 1;

    return pokemonService.getPokemon(pokemonId);
  }
}