import 'package:flutter/material.dart';
import 'package:pokedex/components/pokemon_card.dart';
import 'package:pokedex/controllers/pokemon_list.dart';
import 'package:pokedex/services/pokemon.dart';

class PokemonList extends StatefulWidget {
  const new({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  late final PokemonListController controller;

  final ScrollController scrollController = ScrollController();

  final int _pixelsBeforeMaxScroll = 30;

  @override
  void initState() {
    super.initState();

    controller = PokemonListController(pokemonService: PokemonService());

    scrollController.addListener(_onScroll);

    loadPokemons();
  }

  Future<void> loadPokemons() async {
    await controller.loadPokemons();

    if (!mounted) return;

    setState(() {});
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - _pixelsBeforeMaxScroll) {
      loadPokemons();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16
        ),
        itemCount: controller.pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = controller.pokemons[index];

          return PokemonCard(pokemon: pokemon);
        }),
    );
  }
}