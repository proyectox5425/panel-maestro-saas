// lib/screens/estado_actual.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';

class EstadoActualPage extends StatefulWidget {
  const EstadoActualPage({super.key});

  @override
  State<EstadoActualPage> createState() => _EstadoActualPageState();
}

class _EstadoActualPageState extends State<EstadoActualPage> {
  String estado = 'Consultando...';
  String motivo = '';

  @override
  void initState() {
    super.initState();
    consultarEstado();
  }

  Future<void> consultarEstado() async {
    final supabase = Supabase.instance.client;
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final imei = androidInfo.id;

    final response = await supabase.rpc('rpc_estado_financiero', params: {
      'imei': imei,
    });

    if (response.error != null) {
      setState(() {
        estado = 'Error';
        motivo = response.error!.message;
      });
      return;
    }

    final data = response.data[0];
    setState(() {
      estado = data['estado'];
      motivo = data['motivo'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estado del dispositivo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Estado actual: $estado', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Motivo: $motivo', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            const Text(
              'Este estado se actualiza automáticamente cada vez que el dispositivo se conecta.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
