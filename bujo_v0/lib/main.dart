import 'package:flutter/material.dart';
import 'package:bujo_v0/pages/map.dart';


void main() {
  runApp(const Bujoapp());
}

class Bujoapp extends StatelessWidget {
  const Bujoapp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bujo!',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
         primarySwatch: Colors.blueGrey,
      ),
      home: const Map(),
    );
  }
}


