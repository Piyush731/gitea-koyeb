FROM gitea/gitea:latest

# Environment variables (use defaults but override via Render's env vars)
ENV GITEA__database__DB_TYPE=postgres 
    POSTGRES_HOST=dpg-cvk1ip9r0fns739ln7t0-a \
    POSTGRES_PORT=5432 \
    POSTGRES_DATABASE=gitea_2vo4 \
    POSTGRES_USER=gitea \
    POSTGRES_PASSWORD=4KLdeBUeyIEAMaX357R4YPSS3Z7y6LCh \
     
    GITEA__database__SSL_MODE=require \
    GITEA_ROOT_URL=https://gitea-koyeb.onrender.com/ \
    GITEA__server__HTTP_PORT=3000 \
    GITEA__server__SSH_PORT=2222

# Expose ports
EXPOSE 3000 2222

# Persistence (Render's ephemeral storage - use for temp data only)
VOLUME /data

# Keep original entrypoint
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/bin/s6-svscan", "/etc/s6"]