CREATE TABLE comercios (
  id SERIAL PRIMARY KEY,
  comercio_id VARCHAR(10) UNIQUE NOT NULL,
  nombre TEXT NOT NULL,
  correo TEXT NOT NULL,
  clave_hash TEXT NOT NULL,
  licencias_total INTEGER DEFAULT 0,
  licencias_usadas INTEGER DEFAULT 0,
  estado VARCHAR(10) DEFAULT 'activo',
  creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
