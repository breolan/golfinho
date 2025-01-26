import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<String> history = [
    'Latency: 20ms - 2024-01-01 10:00',
    'Download: 100 Mbps - 2024-01-01 10:05',
    'Packet Loss: 5% - 2024-01-01 10:10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Metric History')),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.timeline),
              title: Text(history[index]),
            ),
          );
        },
      ),
    );
  }
}
