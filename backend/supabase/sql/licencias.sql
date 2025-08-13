-- Tabla: licencias
CREATE TABLE IF NOT EXISTS licencias (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  imei TEXT UNIQUE,
  comercio_id UUID REFERENCES comercios(id) ON DELETE CASCADE,
  lote_id UUID,
  tipo TEXT DEFAULT 'bloqueo_total', -- bloqueo_total, parcial, programado
  estado TEXT DEFAULT 'activa', -- activa, usada, revocada
  activada_en TIMESTAMP DEFAULT NOW(),
  usada_en TIMESTAMP,
  revocada_en TIMESTAMP
);
