// lib/screens/desbloqueo.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'eventos.dart';

class DesbloqueoDispositivo {
  final supabase = Supabase.instance.client;

  Future<bool> intentarDesbloqueo(String comercio, String vendedor) async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    final imei = androidInfo.id;

    final response = await supabase.rpc('rpc_estado_financiero', params: {
      'imei': imei,
    });

    if (response.error != null) {
      throw Exception('Error al consultar estado: ${response.error!.message}');
    }

    final estado = response.data[0]['estado'];

    if (estado == 'activo') {
      await EventosDispositivo().registrarEvento(
        tipo: 'desbloqueo',
        motivo: 'Pago confirmado, desbloqueo automático',
        comercio: comercio,
        vendedor: vendedor,
      );
      return true;
    }

    return false;
  }
}
