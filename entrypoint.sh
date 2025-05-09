#!/bin/sh

echo "Waiting for PostgreSQL to be ready..."

until nc -z -v -w30 $GITEA__database__HOST 5432
do
  echo "Waiting for database connection..."
  sleep 5
done

echo "Database is up - starting Gitea"
exec /usr/bin/entrypoint
