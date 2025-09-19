ARG NODE_VERSION=20.17.0

FROM node:${NODE_VERSION}-alpine AS build

ARG SERVERIP
ARG BACKENDPORT

WORKDIR /app

COPY . .

RUN mkdir -p src/environments && \
   echo "export const environment = { production: false, apiurl: \"http://$SERVERIP:$BACKENDPORT\" };" > src/environments/environment.ts

RUN npm install && npm run build -- --configuration production
##############################################
FROM nginx:latest

COPY --from=build /app/dist/angular-conduit /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d
