FROM nginx:1.19

COPY nginx.conf                            /etc/nginx/nginx.conf

RUN mkdir /etc/nginx/proxy
COPY ip_restriction.conf                   /etc/nginx/proxy/ip_restriction.conf

RUN mkdir /etc/nginx/backends
COPY api_backends.conf                     /etc/nginx/api_backends/api_backends.conf

COPY gitlab-proxy.conf                     /etc/nginx/gitlab-proxy.conf
COPY echoes.conf.template                  /etc/nginx/echoes.conf.template
COPY api_json_errors.conf                  /etc/nginx/api_json_errors.conf
COPY gitlab_api.conf                       /etc/nginx/gitlab_api.conf

COPY gitlab-api-routes/groups.conf         /etc/nginx/gitlab_api_groups.conf
COPY gitlab-api-routes/groups_hooks.conf   /etc/nginx/gitlab_api_groups_hooks.conf
COPY gitlab-api-routes/groups_labels.conf  /etc/nginx/gitlab_api_groups_labels.conf
COPY gitlab-api-routes/projects_hooks.conf /etc/nginx/gitlab_api_projects_hooks.conf
COPY gitlab-api-routes/projects.conf       /etc/nginx/gitlab_api_projects.conf
COPY gitlab-api-routes/users.conf          /etc/nginx/gitlab_api_users.conf
COPY gitlab-api-routes/tags.conf           /etc/nginx/gitlab_api_tags.conf
COPY gitlab-api-routes/discussions.conf    /etc/nginx/gitlab_api_discussions.conf
COPY gitlab-api-routes/merge_requests.conf /etc/nginx/gitlab_api_merge_requests.conf
COPY gitlab-api-routes/namespaces.conf     /etc/nginx/gitlab_api_namespaces.conf
COPY gitlab-api-routes/personal_access_tokens.conf /etc/nginx/gitlab_api_personal_access_tokens.conf
COPY gitlab-api-routes/root.conf           /etc/nginx/gitlab_api_root.conf

RUN mkdir /etc/nginx/api_keys

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
