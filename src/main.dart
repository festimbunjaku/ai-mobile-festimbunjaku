import { createClient } from '@supabase/supabase-js';
const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);
const { data, error } = await supabase.from('profiles').select('*');
console.log(data);