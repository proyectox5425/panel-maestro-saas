// lib/screens/bloqueo.dart

import 'package:flutter/material.dart';
import 'finanzas.dart';

class PantallaBloqueo extends StatefulWidget {
  const PantallaBloqueo({super.key});

  @override
  State<PantallaBloqueo> createState() => _PantallaBloqueoState();
}

class _PantallaBloqueoState extends State<PantallaBloqueo> {
  String motivo = 'Verificando estado financiero...';
  bool desbloqueado = false;

  @override
  void initState() {
    super.initState();
    verificarEstado();
  }

  Future<void> verificarEstado() async {
    final finanzas = FinanzasDispositivo();
    final estado = await finanzas.consultarEstado();

    if (estado['estado'] == 'activo') {
      setState(() {
        desbloqueado = true;
      });
    } else {
      setState(() {
        motivo = estado['motivo'] ?? 'Bloqueo por mora';
      });
      Future.delayed(const Duration(seconds: 30), verificarEstado); // Reintenta cada 30s
    }
  }

  @override
  Widget build(BuildContext context) {
    if (desbloqueado) {
      return const SizedBox.shrink(); // No muestra nada si está desbloqueado
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, color: Colors.red, size: 100),
            const SizedBox(height: 20),
            const Text(
              'Dispositivo bloqueado',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              motivo,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Text(
              'Por favor regularice su situación para continuar.',
              style: TextStyle(color: Colors.white54, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
