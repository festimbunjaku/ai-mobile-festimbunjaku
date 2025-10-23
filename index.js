import { readFileSync } from 'fs';
import { createServer } from 'http';
import { extname, join } from 'path';

const server = createServer((req, res) => {
  // Parse URL to remove hash fragments and query parameters
  const url = new URL(req.url, `http://${req.headers.host}`);
  let filePath = url.pathname;
  
  // Handle root path and hash fragments
  if (filePath === '/' || filePath.startsWith('/#')) {
    filePath = '/index.html';
  }
  
  let contentType = 'text/html';
  
  const ext = extname(filePath);
  switch (ext) {
    case '.js':
      contentType = 'text/javascript';
      break;
    case '.css':
      contentType = 'text/css';
      break;
    case '.json':
      contentType = 'application/json';
      break;
    case '.png':
      contentType = 'image/png';
      break;
    case '.jpg':
      contentType = 'image/jpg';
      break;
  }

  try {
    const content = readFileSync(join(process.cwd(), filePath));
    res.writeHead(200, { 'Content-Type': contentType });
    res.end(content);
  } catch (error) {
    // If file not found, serve index.html for SPA routing
    if (filePath !== '/index.html') {
      try {
        const content = readFileSync(join(process.cwd(), '/index.html'));
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(content);
      } catch (fallbackError) {
        res.writeHead(404);
        res.end('File not found');
      }
    } else {
      res.writeHead(404);
      res.end('File not found');
    }
  }
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, 'localhost', () => {
  console.log(`🚀 AI Mobile Authentication App`);
  console.log(`================================`);
  console.log(`🌐 Server running at: http://localhost:${PORT}`);
  console.log(`📱 Open your browser and go to: http://localhost:${PORT}`);
  console.log(`🔐 Beautiful authentication app ready!`);
  console.log(`✨ Features: Login, Register, Modern UI, Supabase Auth`);
  console.log(`⚡ Press Ctrl+C to stop the server`);
  console.log(`================================`);
});