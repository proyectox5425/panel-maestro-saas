const supabase = supabase.createClient(
  'https://xhqhtzrcohovylcxibkf.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhocWh0enJjb2hvdnlsY3hpYmtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ4Njg3NTEsImV4cCI6MjA3MDQ0NDc1MX0.aTAOD-m3n2n6MAg1Cx2lDOPAD4jT2z4bcQXjxZwgllI'
);

async function login() {
  const correo = document.getElementById('correo').value.trim();
  const clave = document.getElementById('clave').value.trim();
  const feedback = document.getElementById('feedback');

  feedback.textContent = '';

  const { data: session, error } = await supabase.auth.signInWithPassword({
    email: correo,
    password: clave
  });

  if (error) {
    feedback.textContent = 'Correo o clave incorrectos.';
    return;
  }

  const { data: perfil, error: errorPerfil } = await supabase
    .from('usuarios')
    .select('rol')
    .eq('correo', correo)
    .single();

  if (errorPerfil || !perfil || perfil.rol !== 'maestro') {
    feedback.textContent = 'Acceso restringido al panel maestro.';
    return;
  }

  window.location.href = 'dashboard.html';
  }
