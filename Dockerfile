FROM node:lts-alpine
RUN npm i -g http-server
WORKDIR /app
COPY package*.json ./
RUN npm i
COPY . .
RUN npm run build
EXPOSE 8080
CMD ["http-server", "dist"]