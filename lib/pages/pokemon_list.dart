import 'dart:async';
import 'dart:developer';

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

  Timer? _pokemonSearchDebounce;
  String _pokemonSearchText = '';
  int _searchRequestId = 0;

  @override
  void initState() {
    super.initState();

    controller = PokemonListController(pokemonService: PokemonService());

    _scrollController.addListener(_onScroll);

    loadPokemons();
    _loadPokemonNames();
  }

  Future<void> loadPokemons() async {
    await controller.loadPokemons();

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _loadPokemonNames() async {
    await controller.loadPokemonNames();

    if (!mounted) return;

    setState(() {});
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - _pixelsBeforeMaxScroll) {
      loadPokemons();
    }
  }

  void _onSearchChanged(String searchString) {
    _pokemonSearchDebounce?.cancel();

    setState(() {
      _pokemonSearchText = searchString.trim().toLowerCase();
    });

    if (_pokemonSearchText.isEmpty) {
      setState(() {
        controller.searchResults = [];
      });

      return;
    }

    _pokemonSearchDebounce = Timer(
      const Duration(milliseconds: 300),
      () async {
        final requestId = ++_searchRequestId;
        final query = _pokemonSearchText;

        setState(() {
          controller.isSearchingFullDetails = true;
        });

        try {
          await controller.searchPokemons(query);

          if (!mounted || requestId != _searchRequestId) {
            return;
          }

          setState(() {});
        } catch (err) {
          if (!mounted || requestId != _searchRequestId) {
            return;
          }

          log(err.toString());
        } finally {
          if (mounted || requestId == _searchRequestId) {
            setState(() {
              controller.isSearchingFullDetails = false;
            });
          }
        }
      });
  }

  @override
  void dispose() {
    _pokemonSearchDebounce?.cancel();
    _scrollController.dispose();
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String pokemonSearchText = _searchController.text.trim().toLowerCase();

    final isSearchActive = _pokemonSearchText.isNotEmpty;

    final displayedPokemon = isSearchActive ? controller.searchResults : controller.pokemons;

    // final filteredPokemons = controller.allPokemonNames.where((pokemon) {
    //   return pokemon.toLowerCase().contains(pokemonSearchText);
    // }).toList();

    final textFieldBorderColor = displayedPokemon.isNotEmpty ?
      generationColor[Generation.fromPokemonId(displayedPokemon[0].id)]! : Colors.grey[800]!;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 14),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
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
            child: controller.isSearchingFullDetails ?
              const Center(
                child: CircularProgressIndicator(),
              )
              : displayedPokemon.isEmpty
                ? Center(
                  child: Text(
                    isSearchActive ? 'No Pokémon found :(' : 'Loading...'
                  ),
                ) :
            GridView.builder(
              controller: isSearchActive ? null : _scrollController,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                mainAxisExtent: 220
              ),
              itemCount: displayedPokemon.length,
              itemBuilder: (context, index) {
                final pokemon = displayedPokemon[index];
            
                return PokemonCard(pokemon: pokemon);
              }),
          ),
        ],
      ),
    );
  }
}