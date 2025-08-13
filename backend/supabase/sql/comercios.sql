-- Tabla: comercios
CREATE TABLE IF NOT EXISTS comercios (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre TEXT NOT NULL,
  rif TEXT UNIQUE NOT NULL,
  correo TEXT,
  telefono TEXT,
  zona TEXT,
  activo BOOLEAN DEFAULT TRUE,
  creado_en TIMESTAMP DEFAULT NOW()
);
