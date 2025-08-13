-- RPC: enrolar_dispositivo
CREATE OR REPLACE FUNCTION enrolar_dispositivo(
  imei_input TEXT,
  marca_input TEXT,
  modelo_input TEXT,
  cliente_nombre_input TEXT,
  cliente_cedula_input TEXT,
  cliente_telefono_input TEXT,
  vendedor_id_input UUID
)
RETURNS JSON AS $$
DECLARE
  comercio_id_local UUID;
  licencia_id_local UUID;
  lote_id_local UUID;
BEGIN
  -- Obtener comercio del vendedor
  SELECT comercio_id INTO comercio_id_local FROM vendedores WHERE id = vendedor_id_input;

  -- Validar licencia disponible
  SELECT id, lote_id INTO licencia_id_local, lote_id_local
  FROM licencias
  WHERE comercio_id = comercio_id_local AND estado = 'activa'
  LIMIT 1;

  IF licencia_id_local IS NULL THEN
    RETURN json_build_object('status', 'error', 'message', 'No hay licencias disponibles');
  END IF;

  -- Registrar dispositivo
  INSERT INTO dispositivos (
    imei, marca, modelo, estado,
    cliente_nombre, cliente_cedula, cliente_telefono,
    comercio_id, vendedor_id, licencia_id
  ) VALUES (
    imei_input, marca_input, modelo_input, 'activo',
    cliente_nombre_input, cliente_cedula_input, cliente_telefono_input,
    comercio_id_local, vendedor_id_input, licencia_id_local
  );

  -- Marcar licencia como usada
  UPDATE licencias SET estado = 'usada', usada_en = NOW() WHERE id = licencia_id_local;

  -- Actualizar lote
  UPDATE lotes SET cantidad_usada = cantidad_usada + 1 WHERE id = lote_id_local;

  -- Registrar evento
  INSERT INTO eventos (
    imei, tipo, fecha, usuario, panel
  ) VALUES (
    imei_input, 'instalacion', NOW(), vendedor_id_input::TEXT, 'vendedor'
  );

  RETURN json_build_object('status', 'success', 'imei', imei_input);
END;
$$ LANGUAGE plpgsql;
