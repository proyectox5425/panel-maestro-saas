-- RPC: validar_pago
CREATE OR REPLACE FUNCTION validar_pago(imei_input TEXT)
RETURNS JSON AS $$
DECLARE
  pago_confirmado BOOLEAN := FALSE;
BEGIN
  -- Verificar si hay pago confirmado para el IMEI
  SELECT TRUE INTO pago_confirmado
  FROM pagos
  WHERE imei = imei_input AND estado = 'confirmado'
  LIMIT 1;

  IF NOT pago_confirmado THEN
    RETURN json_build_object('status', 'error', 'message', 'Pago no confirmado');
  END IF;

  -- Desbloquear dispositivo
  UPDATE dispositivos SET estado = 'activo' WHERE imei = imei_input;

  -- Registrar evento
  INSERT INTO eventos (
    imei, tipo, fecha, usuario, panel
  ) VALUES (
    imei_input, 'desbloqueo', NOW(), 'sistema', 'cliente'
  );

  RETURN json_build_object('status', 'success', 'imei', imei_input, 'estado', 'activo');
END;
$$ LANGUAGE plpgsql;
