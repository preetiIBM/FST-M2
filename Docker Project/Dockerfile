# Build phase
FROM node:18-alpine as builder
WORKDIR /usr/app
COPY package.json /usr/app
RUN npm install
COPY . .
RUN npm run build


# Run phase

FROM node:18-alpine
WORKDIR /usr/app
COPY package.json /usr/app
RUN npm install
COPY --FROM=builderer /user/app/dist ./
CMD ["npm", "server.js"]