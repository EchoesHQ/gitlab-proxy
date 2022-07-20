# gitlab-proxy

Improve the security guarantees of using [Echoes HQ](https://echoeshq.com)
together with GitLab by proxying the GitLab API. The proxy serves two main
purposes:

* Restrict the set of exposed API endpoints to the subset necessary for Echoes
  HQ to operate.
* Provide its own authentication mechanism so that you don't have to trust
  Echoes HQ with your GitLab token.

See [Echoes documentation](https://docs.echoeshq.com/gitlab-api-proxy) for more
information.

## API keys

The setting of the API keys is done in the `api_keys.conf` file. This file
should be mounted dynamically and not baked into the docker image.

## API routes

Allowed endpoints and methods are defined in `gitlab-api-routes` folder.

## HTTP headers

The proxy always adds the `X-Echoes-GitLab-Proxy-Version`.

## Local development

```console
# navigate to the proxy folder
cd nginx-proxy

# build the proxy
docker build . -t gitlab-proxy

# create a .env file
cp .env.example .env

# run the proxy
docker run \
    --env-file .env \
    -v /tmp/api_keys.conf:/etc/nginx/api_keys.conf:ro \
    -p 8080:80 gitlab-proxy
```

```console
# call the GitLab API via the proxy
curl --location --request GET 'http://0.0.0.0:8080/api/v4/groups/<REPLACE_ME>/members' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: <REPLACE_ME>'
```

## API logs

API Access logs are available for auditing in `/var/log/nginx/api_access.log`

## Configuration with upstream

For on-premises `GitLab` instances, an upstream configuration could be necessary.

In order to use an upstream configuration with the proxy:

- modify the `api_backends.conf` file in order to map the gitlab instance IP(s)
- set the environment variable `GITLAB_URL` as follow: `<protocol><upstream_name>` e,g `http://example`
