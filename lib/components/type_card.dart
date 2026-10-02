import 'package:flutter/material.dart';
import 'package:pokedex/utils/constants.dart';
import 'package:pokedex/utils/functions.dart';

class TypeCard extends StatelessWidget {
  final int id;

  const TypeCard({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final logoUrl = getTypeSpriteUrl(
      id,
      TypeLogoSize.shield,
    );

    return GestureDetector(
      onTap: () {
        debugPrint('cliquei');
      },
      child:
        Row(
          children: [
            Image.network(logoUrl),
          ],
        ),
    );
  }
}