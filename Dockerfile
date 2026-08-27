FROM node:20-alpine

WORKDIR /app

COPY app/package.json ./
COPY app/server.js ./

ENV WEBTEXT="Hello World!"

EXPOSE 80

CMD ["node", "server.js"]
