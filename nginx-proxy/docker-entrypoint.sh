#!/usr/bin/env sh
set -eu

envsubst '${GITLAB_URL}' < /etc/nginx/echoes.conf.template > /etc/nginx/echoes.conf

# clean up the template
rm /etc/nginx/echoes.conf.template

exec "$@"
