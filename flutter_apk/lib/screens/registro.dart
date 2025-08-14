// lib/screens/registro.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class RegistroDispositivo {
  final supabase = Supabase.instance.client;

  Future<void> registrar(String vendedor, String comercio) async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;

    final imei = androidInfo.id; // Alternativa si no hay acceso directo al IMEI
    final modelo = androidInfo.model;

    final response = await supabase.rpc('rpc_registrar_dispositivo', params: {
      'imei': imei,
      'modelo': modelo,
      'vendedor': vendedor,
      'comercio': comercio,
    });

    if (response.error != null) {
      throw Exception('Error al registrar: ${response.error!.message}');
    }
  }
}
