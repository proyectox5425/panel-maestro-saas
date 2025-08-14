import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:imei_plugin/imei_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://TU_URL.supabase.co',
    anonKey: 'TU_PUBLIC_KEY',
  );
  runApp(WiooApp());
}

class WiooApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wioo Cliente',
      home: ValidacionScreen(),
    );
  }
}

class ValidacionScreen extends StatefulWidget {
  @override
  _ValidacionScreenState createState() => _ValidacionScreenState();
}

class _ValidacionScreenState extends State<ValidacionScreen> {
  String resultado = 'Validando...';

  @override
  void initState() {
    super.initState();
    validarDispositivo();
  }

  Future<void> validarDispositivo() async {
    final supabase = Supabase.instance.client;
    final imei = await ImeiPlugin.getImei();
    final modelo = await DeviceInfoPlugin().androidInfo.then((info) => info.model);

    final res = await supabase
        .from('licencias')
        .select()
        .eq('imei', imei)
        .single();

    if (res == null) {
      setState(() {
        resultado = 'Dispositivo no registrado';
      });
    } else if (res['estado'] == 'aprobado') {
      setState(() {
        resultado = '✅ Aprobado';
      });
    } else if (res['estado'] == 'pendiente') {
      setState(() {
        resultado = '🕒 Pendiente';
      });
    } else {
      setState(() {
        resultado = '❌ Rechazado';
      });
    }
  }

  Future<void> registrarDispositivo() async {
    final supabase = Supabase.instance.client;
    final imei = await ImeiPlugin.getImei();
    final modelo = await DeviceInfoPlugin().androidInfo.then((info) => info.model);

    await supabase.from('licencias').insert({
      'imei': imei,
      'modelo': modelo,
      'estado': 'pendiente',
      'fecha': DateTime.now().toIso8601String(),
    });

    setState(() {
      resultado = '🕒 Registrado como pendiente';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Validación institucional')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(resultado, style: TextStyle(fontSize: 24)),
            if (resultado == 'Dispositivo no registrado')
              ElevatedButton(
                onPressed: registrarDispositivo,
                child: Text('Registrar dispositivo'),
              ),
          ],
        ),
      ),
    );
  }
}
