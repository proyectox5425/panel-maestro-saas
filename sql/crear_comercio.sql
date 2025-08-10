CREATE OR REPLACE FUNCTION crear_comercio(
  nombre TEXT,
  correo TEXT,
  clave_plana TEXT,
  licencias_iniciales INTEGER
)
RETURNS TABLE (
  comercio_id TEXT,
  estado TEXT,
  licencias_total INTEGER
)
AS $$
DECLARE
  nuevo_id TEXT := 'COM' || floor(random() * 100000)::TEXT;
BEGIN
  INSERT INTO comercios (
    comercio_id, nombre, correo, clave_hash, licencias_total
  )
  VALUES (
    nuevo_id,
    nombre,
    correo,
    crypt(clave_plana, gen_salt('bf')),
    licencias_iniciales
  );

  RETURN QUERY
  SELECT nuevo_id, 'activo', licencias_iniciales;
END;
$$ LANGUAGE plpgsql;
