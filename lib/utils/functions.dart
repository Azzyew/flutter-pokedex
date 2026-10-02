import 'package:pokedex/utils/constants.dart';

const _baseTypeLogoUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/types/generation-viii/legends-arceus';

String getTypeSpriteUrl(int id, TypeLogoSize typeLogoSize) {
  return typeLogoSize == 
    TypeLogoSize.shield ? '$_baseTypeLogoUrl/$id.png' : '$_baseTypeLogoUrl/small/$id.png';
}