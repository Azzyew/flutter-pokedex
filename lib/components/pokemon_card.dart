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
    }).toList();

    return Card.outlined(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: generationColor[generation]!,
        )
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  '#${pokemon.id.toString().padLeft(4, '0')}',
                  style: TextStyle(color: generationColor[generation]),
                ),
              )
            ],
          ),
          Image.network(pokemon.sprite),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  pokemon.name.capitalize(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: generationColor[generation],
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 6, right: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < formattedTypes.length; i++) ...[
                      TypeRow(
                        imageUrl: formattedTypes[i].imageUrl,
                        typeName: formattedTypes[i].name
                      ),
                      if (i < formattedTypes.length - 1)
                        const SizedBox(height: 4)
                    ]
                  ]
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.height, size: 16, color: Colors.grey[600]),
                        Text(
                          formatPokemonHeight(pokemon.height),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.scale, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 2),
                        Text(
                          formatPokemonWeight(pokemon.weight),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )
    );
  }
}