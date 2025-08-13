// supabaseClient.js
import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm';

export const supabase = createClient(
  'https://xhqhtzrcohovylcxibkf.supabase.co',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhocWh0enJjb2hvdnlsY3hpYmtmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ4Njg3NTEsImV4cCI6MjA3MDQ0NDc1MX0.aTAOD-m3n2n6MAg1Cx2lDOPAD4jT2z4bcQXjxZwgllI'
);
