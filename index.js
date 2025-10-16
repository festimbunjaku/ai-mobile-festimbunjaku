import { createClient } from '@supabase/supabase-js';

// Get credentials from environment variables
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Error: SUPABASE_URL and SUPABASE_ANON_KEY environment variables are required');
  console.log('Please provide your Supabase credentials in the Secrets tab');
  process.exit(1);
}

// Create Supabase client
const supabase = createClient(supabaseUrl, supabaseKey);

// Query the profiles table
async function fetchProfiles() {
  console.log('🔄 Fetching profiles from Supabase...');
  
  const { data, error } = await supabase.from('profiles').select('*');
  
  if (error) {
    console.error('❌ Error fetching profiles:', error.message);
    return;
  }
  
  console.log('✅ Successfully fetched profiles:');
  console.log(data);
}

// Run the query
fetchProfiles();
