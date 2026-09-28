import 'package:flutter/material.dart';
import 'package:pokedex/components/pokemon_of_the_day.dart';
import 'package:pokedex/components/type_card.dart';
import 'package:pokedex/controllers/home.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/pokemon.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;

  Pokemon? pokemon;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();

    controller = HomeController(
      pokemonService: PokemonService(),
    );

    loadPokemon();
  }

  Future<void> loadPokemon() async {
    try {
      final result = await controller.getPokemonOfTheDay();

      if (!mounted) return;

      setState(() {
        pokemon = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        error = 'Erro ao carregar Pokémon';
        isLoading = false;
      });
    }
  }

  Widget buildPokemonOfTheDay() {
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    if (error != null) {
      return Text(error!);
    }

    if (pokemon == null) {
      return const SizedBox.shrink();
    }

    return PokemonOfTheDay(
      pokemon: pokemon!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.only(left: 18, top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pokémon of the day!", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16
            )),

            buildPokemonOfTheDay(),

            Text("All types", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 20,
                  mainAxisExtent: 36 // height of the img in pixels,
                ),
                itemCount: 18,
                itemBuilder: (context, index) {
                  return TypeCard(
                    id: index + 1,
                  );
                }),
            )
          ],
        ),
      ));
  }
}