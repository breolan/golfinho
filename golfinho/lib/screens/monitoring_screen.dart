import 'package:flutter/material.dart';
import 'package:golfinho/models/network_metric.dart'; // Asegúrate de que esta es la ubicación correcta de tu clase NetworkMetric

class MonitoringScreen extends StatefulWidget {
  @override
  _MonitoringScreenState createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  final NetworkMetric _networkMetric = NetworkMetric();

  String speed = "Calculando...";
  String latency = "Calculando...";
  String packetLoss = "Calculando...";
  String networkStatus = "Desconectado";
  String localIp = "Calculando...";
  String wifiName = "Calculando...";

  @override
  void initState() {
    super.initState();
    _fetchNetworkData();
  }

  Future<void> _fetchNetworkData() async {
    String ipAddress = "8.8.8.8";
    final latencyData = await _networkMetric.getLatency(ipAddress);
    final packetLossData = await _networkMetric.getPacketLoss(ipAddress);

    final bandwidthData = await _networkMetric.getBandwidth();

    final isNetworkAvailable = await _networkMetric.checkNetworkAvailability();
    final networkStatusText = isNetworkAvailable ? "Conectado" : "Desconectado";

    final localIpData = await _networkMetric.getLocalIpAddress();
    final wifiNameData = await _networkMetric.getWifiName();

    setState(() {
      latency = latencyData != null ? "$latencyData ms" : "Error";
      packetLoss = packetLossData != null
          ? "${packetLossData.toStringAsFixed(2)}%"
          : "Error";
      speed =
          "${bandwidthData['download']} Mbps de descarga, ${bandwidthData['upload']} Mbps de subida";
      networkStatus = networkStatusText;
      localIp = localIpData ?? "Error al obtener IP local";
      wifiName = wifiNameData ?? "Error al obtener Wi-Fi";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Network Monitoring')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Real-time Metrics',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildMetricCard("Speed", speed, Colors.blue),
                  _buildMetricCard("Latency", latency, Colors.green),
                  _buildMetricCard("Packet Loss", packetLoss, Colors.red),
                  _buildMetricCard(
                      "Network Status", networkStatus, Colors.orange),
                  _buildMetricCard("Local IP", localIp, Colors.purple),
                  _buildMetricCard("Wi-Fi Name", wifiName, Colors.teal),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, Color color) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(Icons.network_check, color: Colors.white),
        ),
        title: Text(label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        subtitle: Text(value, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
