import 'package:flutter/material.dart';

class TypeRow extends StatelessWidget {
  final List<String> imageUrls;

  const TypeRow({
    super.key,
    required this.imageUrls
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: imageUrls.map((url) {
      return Image.network(
        url,
        height: 25,
        width: 25,
        fit: BoxFit.cover,
      );
    }).toList(),
    );
  }
}