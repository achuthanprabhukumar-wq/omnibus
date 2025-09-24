FROM node:16

ARG GROUPAROO_VERSION

WORKDIR /grouparoo

ENV NODE_ENV='production'
ENV PORT=443
ENV WEB_URL=https://omnibus-production.up.railway.app
ENV WEB_SERVER=true
ENV SERVER_TOKEN="default-server-token"
ENV WORKERS=1
ENV REDIS_URL="redis://redis-production-2f49.up.railway.app:6379/0"
ENV DATABASE_URL="postgresql://postgres-lnh0-production.up.railway.app:5432/grouparoo_development"
ENV GROUPAROO_DISTRIBUTION="@grouparoo/omnibus:$GROUPAROO_VERSION"

COPY . .
RUN --mount=type=secret,id=npmrc-cache,target=/grouparoo/.npmrc npm install
RUN npm prune

ENTRYPOINT [ "./node_modules/.bin/grouparoo" ]
CMD [ "start" ]

EXPOSE $PORT/tcp
