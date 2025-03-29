FROM gitea/gitea:latest

# Install tools for debugging and SSL
RUN apk add --no-cache ca-certificates postgresql-client curl

# Database configuration with performance tweaks
ENV GITEA__database__DB_TYPE=postgres \
    GITEA__database__HOST=primary.gitea-db--yvl9svt4dqy6.addon.code.run \
    GITEA__database__PORT=5432 \
    GITEA__database__NAME=gitea \
    GITEA__database__USER=_675e010780806d3b \
    GITEA__database__PASSWD=_5b1b693c837a8f58ca6cdfe5de8b48 \
    GITEA__database__SSL_MODE=require \
    GITEA__database__CONN_MAX_LIFETIME=300 \  # 5-minute connection lifetime
    GITEA__database__LOG_SQL=false \           # Disable verbose logging
    GITEA__server__ROOT_URL=https://p01--gitea-app--yvl9svt4dqy6.code.run \
    GITEA__server__STARTUP_TIMEOUT=1800 \      # 30-minute timeout
    GITEA__security__INSTALL_LOCK=true

# Health check with reduced frequency
HEALTHCHECK --interval=1m --timeout=30s --start-period=5m \
  CMD curl -f http://localhost:3000/api/v1/version || exit 1

VOLUME /data
EXPOSE 3000

# Entrypoint with pre-flight checks
ENTRYPOINT ["sh", "-c", "
  echo '=== Starting Gitea with PostgreSQL Optimization ===';
  echo 'Testing database connectivity...';
  until psql \"postgresql://${GITEA__database__USER}:${GITEA__database__PASSWD}@${GITEA__database__HOST}:${GITEA__database__PORT}/${GITEA__database__NAME}?sslmode=require\" -c 'SELECT 1;' >/dev/null; do
    echo 'Database not ready. Retrying in 15s...';
    sleep 15;
  done;
  echo '=== Starting Gitea Main Process ===';
  /usr/bin/entrypoint
"]
