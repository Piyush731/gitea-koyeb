FROM gitea/gitea:latest

# Set environment variables using Render's environment variables
ENV GITEA__database__DB_TYPE=postgres \
    GITEA__database__HOST="${POSTGRES_HOST}:5432" \
    GITEA__database__PORT="${POSTGRES_PORT}" \
    GITEA__database__NAME="${POSTGRES_DATABASE}" \
    GITEA__database__USER="${POSTGRES_USER}" \
    GITEA__database__PASSWD="${POSTGRES_PASSWORD}" \
    GITEA__server__DISABLE_SSH=true
    GITEA__server__ROOT_URL="${GITEA_ROOT_URL}:3000" \
    GITEA__server__PROTOCOL=http
    GITEA__server__REDIRECT_OTHER_PORT=true \
    GITEA__server__HTTP_PORT=3000 

# Expose web and SSH ports
EXPOSE 3000 2222

# Persistence volume (Render's ephemeral storage)
VOLUME /data

# Use default Gitea entrypoint
ENTRYPOINT ["/usr/bin/entrypoint"] 