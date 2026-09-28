import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';

class PokemonService {
  final String _baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Future<Pokemon> getPokemon(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao tentar carregar o Pokémon');
    }

    final data = jsonDecode(response.body);

    return Pokemon.fromJson(data);
  }
}