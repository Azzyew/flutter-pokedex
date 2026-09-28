import 'package:flutter/material.dart';
import 'package:pokedex/components/type_card.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



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
            // pokemon card here. get pokemon with id day + month
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