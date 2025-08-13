-- RPC: bloquear_dispositivo
CREATE OR REPLACE FUNCTION bloquear_dispositivo(imei_input TEXT, usuario_input TEXT)
RETURNS JSON AS $$
DECLARE
  dispositivo_id UUID;
BEGIN
  -- Validar existencia del IMEI
  SELECT id INTO dispositivo_id FROM dispositivos WHERE imei = imei_input;

  IF dispositivo_id IS NULL THEN
    RETURN json_build_object('status', 'error', 'message', 'IMEI no encontrado');
  END IF;

  -- Actualizar estado
  UPDATE dispositivos SET estado = 'bloqueado' WHERE id = dispositivo_id;

  -- Registrar evento
  INSERT INTO eventos (
    imei, tipo, fecha, usuario, panel
  ) VALUES (
    imei_input, 'bloqueo', NOW(), usuario_input, 'maestro'
  );

  RETURN json_build_object('status', 'success', 'imei', imei_input, 'estado', 'bloqueado');
END;
$$ LANGUAGE plpgsql;
