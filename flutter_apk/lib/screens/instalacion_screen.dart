// lib/screens/instalacion_screen.dart

import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'registro.dart';

class InstalacionScreen extends StatefulWidget {
  const InstalacionScreen({Key? key}) : super(key: key);

  @override
  State<InstalacionScreen> createState() => _InstalacionScreenState();
}

class _InstalacionScreenState extends State<InstalacionScreen> {
  final registro = RegistroDispositivo();
  bool cargando = true;
  String mensaje = 'Validando dispositivo...';

  @override
  void initState() {
    super.initState();
    iniciarInstalacion();
  }

  Future<void> iniciarInstalacion() async {
    try {
      final token = Uri.base.queryParameters['token'];
      if (token != null && token.isNotEmpty) {
        await registro.registrarDesdeToken(token);
        setState(() {
          mensaje = '✅ Dispositivo registrado correctamente';
          cargando = false;
        });
      } else {
        await validarDispositivo();
      }
    } catch (e) {
      setState(() {
        mensaje = '❌ Error: $e';
        cargando = false;
      });
    }
  }

  Future<void> validarDispositivo() async {
    final supabase = Supabase.instance.client;
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final imei = androidInfo.id;

    final response = await supabase.rpc('rpc_validar_dispositivo', params: {
      'imei_input': imei,
    });

    if (response.error != null) {
      throw Exception('Error al validar: ${response.error!.message}');
    }

    final estaRegistrado = response.data as bool;
    setState(() {
      mensaje = estaRegistrado
          ? '✅ Este dispositivo ya está registrado'
          : '⚠️ Dispositivo no registrado';
      cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Instalación del dispositivo')),
      body: Center(
        child: cargando
            ? const CircularProgressIndicator()
            : Text(
                mensaje,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
