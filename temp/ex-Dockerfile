FROM gitea/gitea:latest

# Expose Gitea ports
EXPOSE 3000 22

# Start Gitea
CMD ["/usr/bin/entrypoint", "/bin/s6-svscan", "/etc/s6"]
