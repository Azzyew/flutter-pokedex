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
    var generation = Generation.fromPokemonId(pokemon.id);

    for (var type in pokemon.types) {
      String currentLogoUrl = getTypeSpriteUrl(
        pokemonTypesMap[type]!,
        TypeLogoSize.small,
      );

      typeUrls.add(currentLogoUrl);
    }

    return Card.outlined(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: generationColor[generation]!,
        )
      ),
      child: Column(
        children: [
          Text(
            '#${pokemon.id.toString().padLeft(4, '0')}',
            style: TextStyle(color: generationColor[generation]),
          ),
          Image.network(pokemon.sprite),
          Text(pokemon.name.capitalize()),
          Row(
            children: [
              TypeRow(imageUrls: typeUrls),
              Text('H: ${pokemon.height}'),
              Text('W: ${pokemon.weight}'),
            ],
          )
        ],
      )
    );
  }
}