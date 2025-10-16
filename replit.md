# Project Overview

**Type**: Node.js application with Supabase database integration  
**Current State**: Fully configured and ready to run (requires profiles table in Supabase)  
**Last Updated**: October 16, 2025

## Purpose
A JavaScript application that demonstrates connecting to Supabase and querying a PostgreSQL database using the official Supabase client library.

## Recent Changes
- **October 16, 2025**: Initial project setup
  - Installed Node.js 20 and @supabase/supabase-js package
  - Created index.js with Supabase client connection code
  - Set up workflow to run the application
  - Configured environment variables for SUPABASE_URL and SUPABASE_ANON_KEY
  - Added README with setup instructions

## Project Architecture

### Technology Stack
- **Runtime**: Node.js 20 with ES Modules
- **Database**: Supabase (PostgreSQL)
- **Client Library**: @supabase/supabase-js v2.75.0

### File Structure
```
/
├── index.js          # Main application entry point
├── package.json      # Node.js dependencies and configuration
├── .gitignore        # Git ignore patterns
├── README.md         # User documentation
└── replit.md         # This file (project memory)
```

### Environment Variables
- `SUPABASE_URL` - Supabase project URL
- `SUPABASE_ANON_KEY` - Supabase anonymous API key

Both are stored securely in Replit Secrets.

### Workflow Configuration
- **Name**: Supabase App
- **Command**: `node index.js`
- **Type**: Console output

## Database Schema
The application expects a `profiles` table in Supabase with this structure:
- `id` (uuid, primary key)
- `user_id` (uuid, unique)
- `email` (text, unique)
- `full_name` (text)
- `avatar_url` (text)
- `created_at` (timestamp)
- `updated_at` (timestamp)

## Next Steps
1. Create the profiles table in Supabase (see README.md for SQL)
2. Run the application to verify connection
3. Add sample data to test queries
4. Extend functionality as needed
