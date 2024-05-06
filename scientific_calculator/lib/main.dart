import 'package:flutter/material.dart';
import 'package:scientific_calculator/home.dart';
import 'package:scientific_calculator/scical.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => const Home(),
      '/scical': (context) => const SciCal(),
    },
  ));
}
