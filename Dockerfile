# Dockerfile
FROM gitea/gitea:latest

# Install dependencies for SSL and PostgreSQL connectivity
RUN apk add --no-cache ca-certificates postgresql-client

# Environment Variables (Northflank PostgreSQL Admin Credentials)
ENV GITEA__database__DB_TYPE=postgres \
    GITEA__database__HOST=primary.gitea-db--yvl9svt4dqy6.addon.code.run \
    GITEA__database__PORT=5432 \
    GITEA__database__NAME=gitea \
    GITEA__database__USER=_675e010780806d3b \
    GITEA__database__PASSWD=_5b1b693c837a8f58ca6cdfe5de8b48 \
    GITEA__database__SSL_MODE=require \
    GITEA__database__SSL_CA=/etc/ssl/certs/ca-certificates.crt \
    GITEA__server__ROOT_URL=https://p01--gitea-app--yvl9svt4dqy6.code.run \
    GITEA__server__HTTP_PORT=3000 \
    GITEA__server__PROTOCOL=http \
    GITEA__security__INSTALL_LOCK=true \
    GITEA__server__STARTUP_TIMEOUT=1200

# Health Check
HEALTHCHECK --interval=15s --timeout=5s --start-period=5m --retries=10 \
  CMD psql "postgresql://${GITEA__database__USER}:${GITEA__database__PASSWD}@${GITEA__database__HOST}:${GITEA__database__PORT}/${GITEA__database__NAME}?sslmode=require" -c "SELECT 1;" || exit 1

# Entrypoint with Connection Verification
ENTRYPOINT ["sh", "-c", "echo 'Verifying PostgreSQL connection...'; \
  until psql 'postgresql://${GITEA__database__USER}:${GITEA__database__PASSWD}@${GITEA__database__HOST}:${GITEA__database__PORT}/${GITEA__database__NAME}?sslmode=require' -c 'SELECT 1;' >/dev/null; do \
    echo 'Database not ready. Retrying in 10s...'; sleep 10; \
  done; \
  echo 'Database connection successful!'; \
  /usr/bin/entrypoint"]

VOLUME /data
EXPOSE 3000
