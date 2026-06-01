import 'package:flutter/material.dart';

class Burgers extends StatelessWidget {
  const Burgers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Burgers')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 24),
            Center(
              child: Icon(Icons.fastfood, size: 96, color: Colors.orange),
            ),
            SizedBox(height: 24),
            Text('Burgers', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Classic and gourmet burger options for a satisfying meal.'),
          ],
        ),
      ),
    );
  }
}
