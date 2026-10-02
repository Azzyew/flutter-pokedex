import 'dart:developer';

import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/pokemon.dart';

class PokemonListController {
  final PokemonService pokemonService;

  PokemonListController({
    required this.pokemonService,
  });

  final List<Pokemon> pokemons = [];

  String? _nextPage = PokemonService().firstPokemonRequest;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool get hasMorePokemonToFetch => _nextPage != null;

  Future<void> loadPokemons() async {
    if (_isLoading || !hasMorePokemonToFetch) {
      return;
    }

    _isLoading = true;
  
    try {
      final result = await pokemonService.getPokemons(
        url: _nextPage
      );

      pokemons.addAll(result.pokemon);

      _nextPage = result.next;
    } catch (err) {
      log('Aconteceu um erro: $err');
    } finally {
      _isLoading = false;
    }
  }
}