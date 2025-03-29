# Dockerfile
FROM gitea/gitea:latest

# Install CA certificates for PostgreSQL SSL verification
RUN apk add --no-cache ca-certificates

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

# Persistence and networking
VOLUME /data
EXPOSE 3000

# Health check to verify DB connectivity
HEALTHCHECK --interval=30s --timeout=10s --start-period=2m --retries=3 \
  CMD psql "postgresql://${GITEA__database__USER}:${GITEA__database__PASSWD}@${GITEA__database__HOST}:${GITEA__database__PORT}/${GITEA__database__NAME}?sslmode=require" -c "SELECT 1;" || exit 1

# Entrypoint remains unchanged
ENTRYPOINT ["/usr/bin/entrypoint"]
