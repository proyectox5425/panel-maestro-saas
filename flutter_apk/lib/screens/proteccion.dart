import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ProteccionPage extends StatefulWidget {
  const ProteccionPage({Key? key}) : super(key: key);

  @override
  State<ProteccionPage> createState() => _ProteccionPageState();
}

class _ProteccionPageState extends State<ProteccionPage> {
  String? simStatus;
  String? networkStatus;
  String? reinstallStatus;

  @override
  void initState() {
    super.initState();
    verificarManipulacion();
  }

  Future<void> verificarManipulacion() async {
    final deviceInfo = DeviceInfoPlugin();
    final connectivity = Connectivity();

    // Detectar tipo de red
    final connection = await connectivity.checkConnectivity();
    networkStatus = connection.toString();

    // Detectar reinstalación (placeholder, se reemplaza con RPC institucional)
    reinstallStatus = "verificando...";

    // Detectar SIM (solo Android)
    final androidInfo = await deviceInfo.androidInfo;
    simStatus = androidInfo.serialNumber; // puede cambiar si se cambia SIM

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Protección institucional')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Red actual: $networkStatus'),
            Text('SIM / Serial: $simStatus'),
            Text('Reinstalación: $reinstallStatus'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Enviar evento institucional
              },
              child: const Text('Reportar manipulación'),
            ),
          ],
        ),
      ),
    );
  }
}
