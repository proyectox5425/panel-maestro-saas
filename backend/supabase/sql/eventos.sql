-- Tabla: eventos
CREATE TABLE IF NOT EXISTS eventos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  imei TEXT,
  tipo TEXT NOT NULL, -- instalacion, conexion, bloqueo, desbloqueo, pago, etc.
  fecha TIMESTAMP DEFAULT NOW(),
  ip TEXT,
  usuario TEXT,
  panel TEXT -- maestro, comercio, vendedor, cliente
);
