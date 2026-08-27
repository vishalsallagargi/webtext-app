const http = require('http');

const PORT = 80;
const WEBTEXT = process.env.WEBTEXT || 'Hello World!';

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end(WEBTEXT);
});

server.listen(PORT, () => {
  console.log(`webtext-app listening on port ${PORT}, WEBTEXT="${WEBTEXT}"`);
});
