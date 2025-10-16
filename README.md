# Supabase JavaScript Client Application

A Node.js application that connects to Supabase and queries the profiles table.

## Setup Instructions

### 1. Prerequisites
- A Supabase account and project at https://supabase.com
- Node.js 20+ installed (handled by Replit)

### 2. Environment Variables
Add these secrets in the Replit Secrets tab:
- `SUPABASE_URL` - Your Supabase project URL (e.g., https://xxxxx.supabase.co)
- `SUPABASE_ANON_KEY` - Your Supabase anonymous/public key

### 3. Database Setup
Create the profiles table in your Supabase database using the SQL Editor:

```sql
create extension if not exists "uuid-ossp";

create table if not exists public.profiles (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid unique not null,
  email text unique,
  full_name text,
  avatar_url text,
  created_at timestamp with time zone default timezone('utc', now()),
  updated_at timestamp with time zone default timezone('utc', now())
);

create unique index if not exists profiles_user_id_idx on public.profiles(user_id);

-- Enable Row Level Security
alter table public.profiles enable row level security;

-- Allow users to view their own profile
create policy "Users can view their own profile" 
  on public.profiles for select 
  using (auth.uid() = user_id);
```

### 4. Running the Application
Click the **Run** button in Replit, or use:
```bash
npm start
```

## Project Structure
- `index.js` - Main application file that connects to Supabase and queries profiles
- `package.json` - Node.js dependencies and scripts
- `.gitignore` - Excludes node_modules and environment files from git

## Dependencies
- `@supabase/supabase-js` (v2.75.0) - Official Supabase JavaScript client library

## How It Works
The application:
1. Loads Supabase credentials from environment variables
2. Creates a Supabase client instance
3. Queries all records from the profiles table
4. Displays the results in the console
