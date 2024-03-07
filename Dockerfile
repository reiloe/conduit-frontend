FROM node:18.16-alpine

WORKDIR /app

COPY . ${WORKDIR}

RUN yarn global add @angular/cli \
  && yarn install \
  && yarn build

EXPOSE 4200

ENTRYPOINT ["ng", "serve", "--host", "0.0.0.0", "--port", "4200"]
