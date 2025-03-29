# Dockerfile
FROM gitea/gitea:latest

# Set environment variables directly with your credentials
ENV GITEA__database__DB_TYPE=postgres \
    GITEA__database__HOST=primary.gitea-db--yvl9svt4dqy6.addon.code.run \
    GITEA__database__PORT=5432 \
    GITEA__database__NAME=gitea \
    GITEA__database__USER=_e1d336330a46dfb5 \
    GITEA__database__PASSWD=_02cc845ebfa2de6aa19d4b09901e88 \
    GITEA__database__SSL_MODE=require \
    GITEA__server__ROOT_URL=https://p01--gitea-app--yvl9svt4dqy6.code.run/ \
    GITEA__server__HTTP_PORT=3000

# Persist Gitea data
VOLUME /data

# Expose web interface port
EXPOSE 3000

# Keep default entrypoint
ENTRYPOINT ["/usr/bin/entrypoint"]
