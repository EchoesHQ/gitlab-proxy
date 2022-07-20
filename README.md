# gitlab-proxy

Sits between the GitLab API and the Echoes API

## API keys

The setting of the API keys is done in the `api_keys.conf` file.
This file should be mounted dynamically and not baked into the docker image.

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
