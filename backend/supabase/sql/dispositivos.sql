-- Tabla: dispositivos
CREATE TABLE IF NOT EXISTS dispositivos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  imei TEXT UNIQUE NOT NULL,
  marca TEXT,
  modelo TEXT,
  estado TEXT DEFAULT 'activo', -- activo, bloqueado, tolerancia, finalizado
  cliente_nombre TEXT,
  cliente_cedula TEXT,
  cliente_telefono TEXT,
  comercio_id UUID REFERENCES comercios(id) ON DELETE SET NULL,
  vendedor_id UUID REFERENCES vendedores(id) ON DELETE SET NULL,
  licencia_id UUID,
  instalado_en TIMESTAMP DEFAULT NOW()
);
