import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({
    super.key,
    required this.pokemon
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Column(
        children: [
          Image.network(pokemon.sprite),
          Text(pokemon.name)
        ],
      )
    );
  }
}