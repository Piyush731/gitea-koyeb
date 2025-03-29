FROM gitea/gitea:latest

# Install CA certificates for PostgreSQL SSL
RUN apk add --no-cache ca-certificates

# Database configuration
ENV GITEA__database__DB_TYPE=postgres \
    GITEA__database__HOST=primary.gitea-db--yvl9svt4dqy6.addon.code.run \
    GITEA__database__PORT=5432 \
    GITEA__database__NAME=gitea \
    GITEA__database__USER=_e1d336330a46dfb5 \
    GITEA__database__PASSWD=_02cc845ebfa2de6aa19d4b09901e88 \
    GITEA__database__SSL_MODE=require \
    GITEA__database__SSL_CA=/etc/ssl/certs/ca-certificates.crt \
    GITEA__server__ROOT_URL=https://p01--gitea-app--yvl9svt4dqy6.code.run \
    GITEA__server__HTTP_PORT=3000 \
    GITEA__server__STARTUP_TIMEOUT=600 

# Persistence
VOLUME /data

EXPOSE 3000
ENTRYPOINT ["/usr/bin/entrypoint"]
