FROM gitea/gitea:latest

ENV GITEA__database__DB_TYPE=postgres \
    GITEA__database__HOST=${POSTGRES_HOST} \
    GITEA__database__PORT=${POSTGRES_PORT} \
    GITEA__database__NAME=${POSTGRES_DATABASE} \
    GITEA__database__USER=${POSTGRES_USER} \
    GITEA__database__PASSWD=${POSTGRES_PASSWORD} \
    GITEA__database__SSL_MODE=require \
    GITEA__server__ROOT_URL=${GITEA_ROOT_URL} \
    GITEA__server__PROTOCOL=http \          # <-- Changed to HTTP
    GITEA__server__HTTP_PORT=3000 \
    GITEA__server__REDIRECT_OTHER_PORT=true

EXPOSE 3000
VOLUME /data
ENTRYPOINT ["/usr/bin/entrypoint"]