import 'dart:developer';

import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/pokemon.dart';

class PokemonListController {
  final PokemonService pokemonService;

  PokemonListController({
    required this.pokemonService,
  });

  final List<Pokemon> pokemons = [];
  List<String> allPokemonNames = [];
  List<Pokemon> searchResults = [];

  String? _nextPage = PokemonService().firstPokemonRequest;
  bool _isLoading = false;
  bool isLoadingAllNames = false;
  bool isSearchingFullDetails = false;

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

  Future<void> loadPokemonNames() async {
    if (allPokemonNames.isNotEmpty || isLoadingAllNames) {
      return;
    }

    isLoadingAllNames = true;

    try {
      final allNames = await pokemonService.getAllPokemonNames();
      allPokemonNames.addAll(allNames);
    } catch (err) {
      log(err.toString());
    } finally {
      isLoadingAllNames = false;
    }
  }

  Future<void> searchPokemons(String searchString) async {
    final formattedSearchString = searchString.trim().toLowerCase();

    if (formattedSearchString.isEmpty) {
      searchResults = [];
      return;
    }

    isSearchingFullDetails = true;

    try {
      final matchPokemonNames = allPokemonNames
        .where((pokemonName) => pokemonName.contains(formattedSearchString))
        .take(20)
        .toList();

      final results = await Future.wait(
        matchPokemonNames.map(
          (pokemonName) => pokemonService.getPokemonByName(pokemonName)
        )
      );

      searchResults = results;
    } catch (err) {
      log(err.toString());
    } finally {
      isSearchingFullDetails = false;
    }
  }
}