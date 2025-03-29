FROM gitea/gitea:latest

# Install connection tools
RUN apk add --no-cache postgresql-client

# Force PostgreSQL configuration (USE YOUR CREDENTIALS)
ENV GITEA__database__DB_TYPE=postgres \
    GITEA__database__HOST=primary.gitea-db--yvl9svt4dqy6.addon.code.run \
    GITEA__database__PORT=5432 \
    GITEA__database__NAME=gitea \
    GITEA__database__USER=_675e010780806d3b \
    GITEA__database__PASSWD=_5b1b693c837a8f58ca6cdfe5de8b48 \
    GITEA__database__SSL_MODE=require \
    GITEA__security__INSTALL_LOCK=true \
    GITEA__server__ROOT_URL=https://p01--gitea-app--yvl9svt4dqy6.code.run

# Pre-test connection before starting
ENTRYPOINT ["sh", "-c", "\
  echo 'Waiting for PostgreSQL...'; \
  until PGPASSWORD='_5b1b693c837a8f58ca6cdfe5de8b48' psql -h 'primary.gitea-db--yvl9svt4dqy6.addon.code.run' -p 5432 -U '_675e010780806d3b' -d 'gitea' -c 'SELECT 1;' >/dev/null; do \
    sleep 5; \
  done; \
  echo 'Starting Gitea...'; \
  /usr/bin/entrypoint \
"]

VOLUME /data
EXPOSE 3000
