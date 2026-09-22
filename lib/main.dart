import 'package:flutter/material.dart';
import 'package:pokedex/pages/counter_page.dart';

void main() {
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterPage(),
    );
  }
}