document.body.insertAdjacentHTML('beforeend', '<div style="position:fixed;bottom:10px;left:10px;background:#10b981;color:white;padding:6px;border-radius:4px;z-index:9999;">✅ Script activo</div>');

  import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm';

  const supabase = createClient(
    'https://xhqhtzrcohovylcxibkf.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhocWh0enJjb2hvdnlsY3hpYmtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ4Njg3NTEsImV4cCI6MjA3MDQ0NDc1MX0.aTAOD-m3n2n6MAg1Cx2lDOPAD4jT2z4bcQXjxZwgllI'
  );
  const vendedor_id = '46867ced-d0c6-4311-b8da-24756366aaa2';

  document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('loginForm').addEventListener('submit', function(e) {
      e.preventDefault();
      const correo = e.target.correo.value;
      const clave = e.target.clave.value;

      if (correo === 'vendedor@wioo.app' && clave === '123456') {
        document.getElementById('loginFeedback').innerText = '';
        document.getElementById('menuPrincipal').classList.remove('hidden');
        document.getElementById('enrolamiento').classList.remove('hidden'); 
        e.target.parentElement.classList.add('hidden');
      } else {
        document.getElementById('loginFeedback').innerText = 'Credenciales inválidas';
      }
    });

    document.querySelector('#formEnrolar').addEventListener('submit', async (e) => {
      e.preventDefault();
      const form = e.target;
      const { imei, marca, modelo, cliente_nombre, cliente_cedula, cliente_telefono } = form;

      const { data, error } = await supabase.rpc('enrolar_dispositivo', {
        imei_input: imei.value,
        marca_input: marca.value,
        modelo_input: modelo.value,
        cliente_nombre_input: cliente_nombre.value,
        cliente_cedula_input: cliente_cedula.value,
        cliente_telefono_input: cliente_telefono.value,
        vendedor_id_input: vendedor_id
      });

      const feedback = document.getElementById('feedbackEnrolamiento');
      if (error) {
        feedback.innerText = `❌ Error: ${error.message}`;
        feedback.classList.add('text-red-600');
      } else {
        feedback.innerText = `✅ Dispositivo enrolado: ${data.imei}`;
        feedback.classList.add('text-green-600');
        form.reset();
      }
    });
  });
