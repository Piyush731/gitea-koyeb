FROM gitea/gitea:latest

# Set volume mount point
VOLUME ["/data"]

# Use custom entrypoint to ensure DB is ready
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
