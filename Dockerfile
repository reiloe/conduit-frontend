ARG NODE_VERSION=20.17.0

FROM node:${NODE_VERSION}-alpine AS base

WORKDIR /app
##############################################
FROM base AS build

COPY . .

RUN sed -i'.bak' -e "s/#SERVERIP/$SERVERIP/g" srv/environments/environment.ts
RUN npm install && npm run build -- --configuration production
##############################################
FROM nginx:latest

COPY --from=build /app/dist/angular-conduit /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d
