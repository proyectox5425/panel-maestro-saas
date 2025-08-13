-- Tabla: pagos
CREATE TABLE IF NOT EXISTS pagos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  imei TEXT NOT NULL,
  comercio_id UUID REFERENCES comercios(id) ON DELETE SET NULL,
  monto NUMERIC(10,2) NOT NULL,
  referencia TEXT,
  metodo TEXT, -- zelle, pago_movil, efectivo, etc.
  estado TEXT DEFAULT 'pendiente', -- pendiente, confirmado, rechazado
  fecha_pago TIMESTAMP DEFAULT NOW(),
  validado_en TIMESTAMP,
  validado_por UUID, -- vendedor o sistema
  cliente_nombre TEXT,
  cliente_cedula TEXT
);
