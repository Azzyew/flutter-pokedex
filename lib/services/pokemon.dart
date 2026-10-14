import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';

class PokemonService {
  final String _baseUrl = 'https://pokeapi.co/api/v2/pokemon';
  final String firstPokemonRequest = 'https://pokeapi.co/api/v2/pokemon?limit=20&offset=0';

  Future<Pokemon> getPokemonById(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Error trying to load Pokémon by id');
    }

    final data = jsonDecode(response.body);

    return Pokemon.fromJson(data);
  }


  Future<Pokemon> getPokemonByName(String name) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$name')
    );

    if (response.statusCode != 200) {
      throw Exception('Error trying to load Pokémon by name');
    }

    return Pokemon.fromJson(jsonDecode(response.body));
  }

  Future<PokemonPage> getPokemons({
    String? url,
    int? limit = 20,
    int? offset = 0
  }) async {
    final requestUrl = url ?? '$_baseUrl?limit=$limit&offset=$offset';

    final response = await http.get(
      Uri.parse(requestUrl),
    );

    if (response.statusCode != 200) {
      throw Exception('Error trying to load Pokémons');
    }

    final data = jsonDecode(response.body);

    final results = data['results'] as List;

    final responses = await Future.wait(
      results.map(
        (pokemon) => http.get(
          Uri.parse(pokemon['url']),
        ),
      ),
    );

    final pokemons = responses.map((response) {
      return Pokemon.fromJson(
        jsonDecode(response.body)
      );
    }).toList();

    return PokemonPage(pokemon: pokemons, next: data['next']);
  }

  Future<List<String>> getAllPokemonNames() async {
    final response = await http.get(
      Uri.parse('$_baseUrl?limit=1500&offset=0')
    );

    if (response.statusCode != 200) {
      throw Exception('Error trying to load all Pokémons');
    }

    final results = jsonDecode(response.body)['results'] as List;

    return results.map((pokemon) => pokemon['name'] as String).toList();
  }
}