FROM gitea/gitea:latest

# Set working directory
WORKDIR /data

# Expose necessary ports
EXPOSE 3000 22

# Use Gitea's default entrypoint
CMD ["/usr/bin/entrypoint"]
