import { readFileSync } from 'fs';
import { createServer } from 'http';
import { extname, join } from 'path';

const server = createServer((req, res) => {
  let filePath = req.url === '/' ? '/index.html' : req.url;
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
    res.writeHead(404);
    res.end('File not found');
  }
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`🚀 AI Mobile App running on port ${PORT}`);
  console.log(`📱 Open your browser and navigate to the URL shown above`);
  console.log(`🔐 Your beautiful authentication app is ready!`);
  console.log(`✨ Features: Login, Register, Modern UI, Supabase Auth`);
});