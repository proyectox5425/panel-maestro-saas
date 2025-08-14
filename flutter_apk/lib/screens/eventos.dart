// lib/screens/eventos.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';

class EventosDispositivo {
  final supabase = Supabase.instance.client;

  Future<void> registrarEvento({
    required String tipo,
    required String motivo,
    required String comercio,
    required String vendedor,
  }) async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final imei = androidInfo.id;

    final response = await supabase.from('eventos_dispositivo').insert({
      'imei': imei,
      'tipo': tipo,
      'motivo': motivo,
      'comercio': comercio,
      'vendedor': vendedor,
    });

    if (response.error != null) {
      throw Exception('Error al registrar evento: ${response.error!.message}');
    }
  }
}
