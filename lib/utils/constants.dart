
import 'package:flutter/material.dart';

enum TypeLogoSize { shield, small }

enum Generation {
  genI,
  genII,
  genIII,
  genIV,
  genV,
  genVI,
  genVII,
  genVIII,
  genIX;

  static Generation fromPokemonId(int pokemonId) {
    if (pokemonId < 151) {
      return Generation.genI;
    }
    
    if (pokemonId < 251) {
      return Generation.genII;
    }

    if (pokemonId < 386) {
      return Generation.genIII;
    }

    if (pokemonId < 493) {
      return Generation.genIV;
    }

    if (pokemonId < 649) {
      return Generation.genV;
    }

    if (pokemonId < 721) {
      return Generation.genVI;
    }

    if (pokemonId < 809) {
      return Generation.genVII;
    }

    if (pokemonId < 905) {
      return Generation.genVIII;
    }

    return Generation.genIX;
  }
}

final Map<Generation, Color> generationColor = {
  Generation.genI: Colors.teal[300]!,
  Generation.genII: Colors.teal[400]!,
  Generation.genIII: Colors.cyan[300]!,
  Generation.genIV: Colors.cyan[400]!,
  Generation.genV: Colors.cyan[500]!,
  Generation.genVI: Colors.cyan[600]!,
  Generation.genVII: Colors.cyan[700]!,
  Generation.genVIII: Colors.cyan[800]!,
  Generation.genIX: Colors.cyan[900]!,
};

const Map<String, int> pokemonTypesMap = {
  'normal': 1,
  'fighting': 2,
  'flying': 3,
  'poison': 4,
  'ground': 5,
  'rock': 6,
  'bug': 7,
  'ghost': 8,
  'steel': 9,
  'fire': 10,
  'water': 11,
  'grass': 12,
  'electric': 13,
  'psychic': 14,
  'ice': 15,
  'dragon': 16,
  'dark': 17,
  'fairy': 18,
  'stellar': 19,
};