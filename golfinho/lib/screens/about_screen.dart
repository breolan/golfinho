import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Golfiño')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Golfiño - Network Monitoring Tool',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Developed by Team XYZ', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text('Version 1.0.0'),
          ],
        ),
      ),
    );
  }
}
