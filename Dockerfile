FROM gitea/gitea:latest

# 1. Install tools for debugging
RUN apk add --no-cache ca-certificates postgresql-client curl

# 2. Override ALL database settings (use your admin credentials)
ENV GITEA__database__DB_TYPE=postgres \
    GITEA__database__HOST=primary.gitea-db--yvl9svt4dqy6.addon.code.run \
    GITEA__database__PORT=5432 \
    GITEA__database__NAME=gitea \
    GITEA__database__USER=_675e010780806d3b \
    GITEA__database__PASSWD=_5b1b693c837a8f58ca6cdfe5de8b48 \
    GITEA__database__SSL_MODE=require \
    GITEA__security__INSTALL_LOCK=true \
    GITEA__server__ROOT_URL=https://p01--gitea-app--yvl9svt4dqy6.code.run

# 3. Delete any existing config on startup
RUN echo "#!/bin/sh\nrm -f /data/gitea/conf/app.ini\n/usr/bin/entrypoint \"\$@\"" > /start.sh && chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
VOLUME /data
EXPOSE 3000
