import 'package:flutter/material.dart';
import 'package:pokedex/extensions/string.dart';

class TypeRow extends StatelessWidget {
  final String imageUrl;
  final String typeName;

  const TypeRow({
    super.key,
    required this.imageUrl,
    required this.typeName
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          imageUrl,
          height: 25,
          width: 25,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(typeName.capitalize()),
        )
      ]
    );
  }
}