FROM gitea/gitea:latest

# Install CA certificates and PostgreSQL client
RUN apk add --no-cache ca-certificates postgresql-client

# Force external PostgreSQL configuration
ENV GITEA__database__DB_TYPE=postgres \
    GITEA__database__HOST=primary.gitea-db--yvl9svt4dqy6.addon.code.run \
    GITEA__database__PORT=5432 \
    GITEA__database__NAME=gitea \
    GITEA__database__USER=_675e010780806d3b \
    GITEA__database__PASSWD=_5b1b693c837a8f58ca6cdfe5de8b48 \
    GITEA__database__SSL_MODE=require \
    GITEA__server__ROOT_URL=https://p01--gitea-app--yvl9svt4dqy6.code.run \
    GITEA__server__HTTP_PORT=3000 \
    GITEA__security__INSTALL_LOCK=true \
    GITEA__server__STARTUP_TIMEOUT=1200     # 20-minute timeout

# Verify connectivity before starting Gitea
ENTRYPOINT ["sh", "-c", "echo 'Testing PostgreSQL connection...' && \
  until psql 'postgresql://${GITEA__database__USER}:${GITEA__database__PASSWD}@${GITEA__database__HOST}:${GITEA__database__PORT}/${GITEA__database__NAME}?sslmode=require' -c 'SELECT 1;' >/dev/null; do \
    echo 'Waiting for database...'; sleep 10; \
  done && \
  /usr/bin/entrypoint"]

VOLUME /data
EXPOSE 3000
