import 'package:pokedex/utils/constants.dart';

const _baseTypeLogoUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/types/generation-viii/legends-arceus';

String getTypeSpriteUrl(int id, TypeLogoSize typeLogoSize) {
  return typeLogoSize == 
    TypeLogoSize.shield ? '$_baseTypeLogoUrl/$id.png' : '$_baseTypeLogoUrl/small/$id.png';
}

String formatPokemonHeight(String decimeters) {
  final meters = int.parse(decimeters) / 10;

  return '${meters.toStringAsFixed(1)}m';
}

String formatPokemonWeight(String hectograms) {
  final kg = int.parse(hectograms) / 10;

  return '${kg.toStringAsFixed(1)}kg';
}