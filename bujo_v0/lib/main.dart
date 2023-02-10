import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bujo_v0/pages/map.dart';
import 'firebase_options.dart';


void main() {
  Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
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


