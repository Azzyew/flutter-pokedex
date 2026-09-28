import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const new({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {

  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Você clicou $_counter vezes"),
          TextButton(
            onPressed: _increment,
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
            child: Text("Clique aqui", style: TextStyle(color: Colors.white)))
        ],
      )),
    );
  }
}