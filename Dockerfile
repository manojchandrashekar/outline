FROM arm64v8/node:14-alpine

ENV APP_PATH /opt/outline
RUN mkdir -p $APP_PATH

WORKDIR $APP_PATH

COPY package.json ./
COPY yarn.lock ./

RUN yarn --pure-lockfile

COPY . .

RUN yarn build && \
  yarn --production --ignore-scripts --prefer-offline && \
  rm -rf shared && \
  rm -rf app

CMD yarn start

EXPOSE 3000
