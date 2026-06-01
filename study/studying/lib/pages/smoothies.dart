import 'package:flutter/material.dart';

class Smoothies extends StatelessWidget {
  const Smoothies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smoothies')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 24),
            Center(
              child: Icon(Icons.local_drink, size: 96, color: Colors.deepPurple),
            ),
            SizedBox(height: 24),
            Text('Smoothies', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Delicious and healthy blended drinks for breakfast or snacks.'),
          ],
        ),
      ),
    );
  }
}
