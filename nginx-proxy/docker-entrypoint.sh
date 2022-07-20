#!/usr/bin/env sh
set -eu

envsubst '${GITLAB_URL}' < /etc/nginx/gitlab-proxy.conf.template > /etc/nginx/gitlab-proxy.conf

# clean up the template
rm /etc/nginx/gitlab-proxy.conf.template

exec "$@"
