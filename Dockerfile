FROM node:16 as builder

WORKDIR /usr/src/app
COPY package*.json ./

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

FROM node:16-alpine

WORKDIR /usr/src/app

COPY package*.json ./
RUN yarn install --frozen-lockfile --production=true

COPY --from=builder /usr/src/app/dist .

EXPOSE 8080
CMD [ "node", "index.js" ]