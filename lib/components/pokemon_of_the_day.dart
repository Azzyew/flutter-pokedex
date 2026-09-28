import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonOfTheDay extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonOfTheDay({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Row(
        children: [
          Image.network(pokemon.sprite),
          Text(pokemon.name),
          Text(pokemon.types.join(' / ')),
        ],
      ),
    );
  }
}