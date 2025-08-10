import { useState } from 'react';

export default function CrearComercio() {
  const [nombre, setNombre] = useState('');
  const [correo, setCorreo] = useState('');
  const [clave, setClave] = useState('');
  const [licencias, setLicencias] = useState(0);
  const [respuesta, setRespuesta] = useState(null);

  const crearComercio = async () => {
    const res = await fetch('/api/crear-comercio', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ nombre, correo, clave, licencias })
    });
    const data = await res.json();
    setRespuesta(data);
  };

  return (
    <div className="p-4">
      <h2 className="text-xl font-bold mb-2">🧱 Crear Comercio</h2>
      <input placeholder="Nombre" onChange={e => setNombre(e.target.value)} />
      <input placeholder="Correo" onChange={e => setCorreo(e.target.value)} />
      <input placeholder="Clave" type="password" onChange={e => setClave(e.target.value)} />
      <input placeholder="Licencias iniciales" type="number" onChange={e => setLicencias(e.target.value)} />
      <button onClick={crearComercio}>Crear</button>

      {respuesta && (
        <div className="mt-4">
          ✅ Comercio creado: {respuesta.comercio_id} con {respuesta.licencias_total} licencias
        </div>
      )}
    </div>
  );
    }
