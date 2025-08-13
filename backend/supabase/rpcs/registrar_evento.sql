-- RPC: registrar_evento
CREATE OR REPLACE FUNCTION registrar_evento(
  imei_input TEXT,
  tipo_input TEXT,
  usuario_input TEXT,
  panel_input TEXT
)
RETURNS JSON AS $$
BEGIN
  INSERT INTO eventos (
    imei, tipo, fecha, usuario, panel
  ) VALUES (
    imei_input, tipo_input, NOW(), usuario_input, panel_input
  );

  RETURN json_build_object('status', 'success', 'imei', imei_input, 'evento', tipo_input);
END;
$$ LANGUAGE plpgsql;
