// lib/screens/finanzas.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class FinanzasDispositivo {
  final supabase = Supabase.instance.client;

  Future<Map<String, String>> consultarEstado() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final imei = androidInfo.id;

    final response = await supabase.rpc('rpc_estado_financiero', params: {
      'imei': imei,
    });

    if (response.error != null) {
      throw Exception('Error financiero: ${response.error!.message}');
    }

    final data = response.data[0];
    return {
      'estado': data['estado'],
      'motivo': data['motivo'],
    };
  }
}
