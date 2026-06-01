import 'package:flutter/material.dart';

class Pasta extends StatelessWidget {
  const Pasta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pasta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 24),
            Center(
              child: Icon(Icons.ramen_dining, size: 96, color: Colors.redAccent),
            ),
            SizedBox(height: 24),
            Text('Pasta', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Comforting pasta dishes for dinner and family meals.'),
          ],
        ),
      ),
    );
  }
}
