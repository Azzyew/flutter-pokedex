import 'package:flutter/material.dart';
import 'package:pokedex/components/pokemon_card.dart';
import 'package:pokedex/controllers/pokemon_list.dart';
import 'package:pokedex/services/pokemon.dart';
import 'package:pokedex/utils/constants.dart';

class PokemonList extends StatefulWidget {
  const new({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  late final PokemonListController controller;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  final int _pixelsBeforeMaxScroll = 30;

  @override
  void initState() {
    super.initState();

    controller = PokemonListController(pokemonService: PokemonService());

    _scrollController.addListener(_onScroll);

    loadPokemons();
  }

  Future<void> loadPokemons() async {
    await controller.loadPokemons();

    if (!mounted) return;

    setState(() {});
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - _pixelsBeforeMaxScroll) {
      loadPokemons();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String pokemonSearchText = _searchController.text.trim().toLowerCase();

    final filteredPokemons = controller.pokemons.where((pokemon) {
      return pokemon.name.toLowerCase().contains(pokemonSearchText);
    }).toList();

    final textFieldBorderColor = filteredPokemons.isNotEmpty ?
      generationColor[Generation.fromPokemonId(filteredPokemons[0].id)]! : Colors.grey[800]!;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 14),
            child: TextField(
              controller: _searchController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: textFieldBorderColor
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: textFieldBorderColor
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                labelText: 'Enter a Pokémon',
                prefixIcon: Icon(Icons.search)
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                mainAxisExtent: 220
              ),
              itemCount: filteredPokemons.length,
              itemBuilder: (context, index) {
                final pokemon = filteredPokemons[index];
            
                return PokemonCard(pokemon: pokemon);
              }),
          ),
        ],
      ),
    );
  }
}