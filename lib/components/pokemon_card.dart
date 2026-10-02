import 'package:flutter/material.dart';
import 'package:pokedex/components/type_row.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/extensions/string.dart';
import 'package:pokedex/utils/constants.dart';
import 'package:pokedex/utils/functions.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({
    super.key,
    required this.pokemon
  });

  @override
  Widget build(BuildContext context) {
    List<String> typeUrls = [];

    for (var type in pokemon.types) {
      String currentLogoUrl = getTypeSpriteUrl(
        pokemonTypesMap[type]!,
        TypeLogoSize.small,
      );

      typeUrls.add(currentLogoUrl);
    }

    return Card.outlined(
      child: Column(
        children: [
          Image.network(pokemon.sprite),
          Text(pokemon.name.capitalize()),
          // Text(pokemon.types.join('/'))
          TypeRow(imageUrls: typeUrls)
        ],
      )
    );
  }
}