import 'package:dart_ping/dart_ping.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:network_info_plus/network_info_plus.dart';

class NetworkMetric {
  final FlutterInternetSpeedTest _speedTest = FlutterInternetSpeedTest();
  final NetworkInfo _networkInfo = NetworkInfo();

  // Método para medir la latencia (ping)
  Future<int?> getLatency(String ipAddress) async {
    try {
      final ping = Ping(ipAddress, count: 5);
      int? avgLatency;

      await for (final PingData data in ping.stream) {
        if (data.response != null) {
          avgLatency = data.response?.time?.inMilliseconds;
        }
      }
      return avgLatency;
    } catch (e) {
      print('Error al medir latencia: $e');
      return null;
    }
  }

  // Método para medir la pérdida de paquetes
  Future<double?> getPacketLoss(String ipAddress) async {
    try {
      final ping = Ping(ipAddress, count: 5);
      int transmitted = 0;
      int received = 0;

      await for (final PingData data in ping.stream) {
        transmitted++;
        if (data.response != null) received++;
      }

      double packetLoss = ((transmitted - received) / transmitted) * 100;
      return packetLoss;
    } catch (e) {
      print('Error al medir pérdida de paquetes: $e');
      return null;
    }
  }

  // Método para medir el ancho de banda (descarga y subida)
  Future<Map<String, double>> getBandwidth() async {
    double downloadSpeed = 0.0;
    double uploadSpeed = 0.0;

    try {
      await _speedTest.startTesting(
        useFastApi: true, // Usar Fast.com como servidor predeterminado
        onDownloadComplete: (TestResult data) {
          downloadSpeed = data.transferRate;
          print('Velocidad de descarga: ${data.transferRate} ${data.unit}');
        },
        onUploadComplete: (TestResult data) {
          uploadSpeed = data.transferRate;
          print('Velocidad de subida: ${data.transferRate} ${data.unit}');
        },
        onCompleted: (TestResult download, TestResult upload) {
          print(
              'Test completado: Descarga ${download.transferRate} ${download.unit}, Subida ${upload.transferRate} ${upload.unit}');
        },
        onProgress: (percent, data) {
          print('Progreso: $percent% - ${data.transferRate} ${data.unit}');
        },
        onError: (errorMessage, speedTestError) {
          print('Error: $errorMessage - $speedTestError');
        },
      );
    } catch (e) {
      print('Error durante la prueba de velocidad: $e');
    }

    return {
      'download': downloadSpeed, // Mbps de descarga
      'upload': uploadSpeed, // Mbps de subida
    };
  }

  // Método para verificar la disponibilidad de la red (Wi-Fi o datos móviles)
  Future<bool> checkNetworkAvailability() async {
    try {
      String? wifiName = await _networkInfo.getWifiName();
      return wifiName != null;
    } catch (e) {
      print('Error al verificar disponibilidad de red: $e');
      return false;
    }
  }

  // Método para obtener la dirección IP de la red local
  Future<String?> getLocalIpAddress() async {
    try {
      return await _networkInfo.getWifiIP();
    } catch (e) {
      print('Error al obtener la dirección IP local: $e');
      return null;
    }
  }

  // Método para obtener el nombre de la red Wi-Fi
  Future<String?> getWifiName() async {
    try {
      return await _networkInfo.getWifiName();
    } catch (e) {
      print('Error al obtener el nombre de la red Wi-Fi: $e');
      return null;
    }
  }
}
