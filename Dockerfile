FROM gitea/gitea:latest

ENV GITEA__database__DB_TYPE=postgres \
    GITEA__database__HOST=dpg-cvk1ip9r0fns739ln7t0-a \ 
    GITEA__database__PORT=5432 \
    GITEA__database__NAME=gitea_2vo4 \ 
    GITEA__database__USER=gitea \ 
    GITEA__database__PASSWD=4KLdeBUeyIEAMaX357R4YPSS3Z7y6LCh \
    GITEA__database__SSL_MODE=require \
    GITEA__server__ROOT_URL=https://gitea-koyeb.onrender.com \
    GITEA__server__PROTOCOL=http \
    GITEA__server__HTTP_PORT=3000 \
    GITEA__server__REDIRECT_OTHER_PORT=true

EXPOSE 3000
VOLUME /data
ENTRYPOINT ["/usr/bin/entrypoint"]