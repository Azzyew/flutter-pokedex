import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan[500],
      child: TabBar(
        labelColor: Colors.grey[200],
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.all(5),
        indicatorColor: Colors.white,
        tabs: [
          Tab(
            icon: Icon(Icons.home),
          ),
          Tab(
            icon: Icon(Icons.list_alt),
          )
        ]
      ),
    );
  }
}