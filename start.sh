#!/bin/bash

echo "🚀 AI Mobile Authentication App"
echo "================================"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed!"
    echo "Please install Node.js from https://nodejs.org/"
    exit 1
fi

# Check if dependencies are installed
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
    echo ""
fi

# Check if Supabase credentials are configured
if grep -q "YOUR_SUPABASE_URL" index.html; then
    echo "⚠️  WARNING: Supabase credentials not configured!"
    echo "Please update index.html with your Supabase URL and anon key"
    echo "See LOCAL_SETUP.md for instructions"
    echo ""
fi

echo "🌐 Starting server..."
echo "📱 Open your browser to: http://localhost:3000"
echo "⚡ Press Ctrl+C to stop the server"
echo "================================"
echo ""

# Start the server
npm start
