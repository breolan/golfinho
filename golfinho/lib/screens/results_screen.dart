import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final List<String> anomalies = [
    'High latency',
    'Packet loss detected',
    'Slow download speed'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Analysis Results')),
      body: ListView.builder(
        itemCount: anomalies.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.warning, color: Colors.red),
            title: Text(anomalies[index]),
            subtitle: Text('Detected at ${DateTime.now()}'),
          );
        },
      ),
    );
  }
}
