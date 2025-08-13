-- Tabla: lotes
CREATE TABLE IF NOT EXISTS lotes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  comercio_id UUID REFERENCES comercios(id) ON DELETE CASCADE,
  cantidad_total INTEGER NOT NULL,
  cantidad_usada INTEGER DEFAULT 0,
  tipo TEXT DEFAULT 'bloqueo_total', -- bloqueo_total, parcial, programado
  tolerancia_dias INTEGER DEFAULT 3,
  activado_en TIMESTAMP DEFAULT NOW(),
  expiracion TIMESTAMP,
  estado TEXT DEFAULT 'activo' -- activo, agotado, revocado
);
