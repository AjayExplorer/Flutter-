import 'package:flutter/material.dart';
class Salad extends StatelessWidget {
  const Salad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salads')),
      body: const Center(child: Text('Welcome to the Salad page!')),
    );
  }
}