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
    var generation = Generation.fromPokemonId(pokemon.id);


    final formattedTypes = pokemon.types.map((type) {
      return PokemonType(
        name: type,
        imageUrl: getTypeSpriteUrl(
          pokemonTypesMap[type]!,
          TypeLogoSize.small,
        ),
      );
    });

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
              Column(
                children: formattedTypes.map((type) {
                  return TypeRow(typeName: type.name, imageUrl: type.imageUrl);
                }).toList()
              ),
              Column(
                children: [
                  Text(formatPokemonHeight(pokemon.height)),
                  Text(formatPokemonWeight(pokemon.weight)),
                ],
              )
            ],
          )
        ],
      )
    );
  }
}