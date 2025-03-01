import 'package:flutter/material.dart';

void main() {
  runApp(const FinalProject2025());
}

class FinalProject2025 extends StatelessWidget {
  const FinalProject2025({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project 2025',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Container(),
    );
  }
}
