import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/components/bottom_nav.dart';
import 'package:pokedex/pages/home.dart';
import 'package:pokedex/pages/pokemon_list.dart';

void main() {
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.mozillaHeadline().fontFamily,
        primaryColor: Colors.cyan[500]
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Pokédex",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
            ),
            elevation: 0,
            backgroundColor: Colors.cyan[500],
          ),
          bottomNavigationBar: BottomNav(),
          body: const TabBarView(
            children: [
              HomePage(),
              PokemonList(),
            ],
          ),
        ),
      ),
    );
  }
}