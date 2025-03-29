FROM gitea/gitea:latest

# Set environment variables (use your ADMIN credentials)
ENV GITEA__database__DB_TYPE=postgres \
    GITEA__database__HOST=primary.gitea-db--yvl9svt4dqy6.addon.code.run \
    GITEA__database__PORT=5432 \
    GITEA__database__NAME=gitea \
    GITEA__database__USER=_675e010780806d3b \
    GITEA__database__PASSWD=_5b1b693c837a8f58ca6cdfe5de8b48 \
    GITEA__database__SSL_MODE=require \
    GITEA__server__ROOT_URL=https://p01--gitea-app--yvl9svt4dqy6.code.run

VOLUME /data
EXPOSE 3000
