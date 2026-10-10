class Pokemon {
  final int id;
  final String name;
  final String sprite;
  final String height;
  final String weight;
  final List<String> types;

  const Pokemon({
    required this.id,
    required this.name,
    required this.sprite,
    required this.height,
    required this.weight,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json['height'].toString(),
      weight: json['weight'].toString(),
      sprite: json['sprites']['front_default'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
    );
  }
}

class PokemonPage {
  final List<Pokemon> pokemon;
  final String? next;

  const PokemonPage({
    required this.pokemon,
    required this.next
  });
}