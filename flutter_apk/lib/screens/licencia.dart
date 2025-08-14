// lib/screens/licencia.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';

class LicenciaDispositivo {
  final supabase = Supabase.instance.client;

  Future<Map<String, dynamic>> validarLicencia() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final imei = androidInfo.id;

    final response = await supabase.rpc('rpc_validar_licencia', params: {
      'imei': imei,
    });

    if (response.error != null) {
      throw Exception('Error al validar licencia: ${response.error!.message}');
    }

    final data = response.data[0];
    return {
      'estado': data['estado'],
      'comercio': data['comercio'],
      'vendedor': data['vendedor'],
      'fecha_activacion': data['fecha_activacion'],
      'tipo_licencia': data['tipo_licencia'],
    };
  }
}
