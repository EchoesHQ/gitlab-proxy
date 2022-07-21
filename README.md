# gitlab-proxy

Improve the security guarantees of using [Echoes HQ](https://echoeshq.com)
together with GitLab by proxying the GitLab API. The proxy serves two main
purposes:

- Restrict the set of exposed API endpoints to the subset necessary for Echoes
  HQ to operate.
- Provide its own authentication mechanism so that you don't have to trust
  Echoes HQ with your GitLab token.

See [Echoes documentation](https://docs.echoeshq.com/gitlab-api-proxy) for more
information.

## Quickstart

### Step 1: Clone the repository

```console
git clone git@github.com:EchoesHQ/gitlab-proxy.git
```

### Step 2: Build the Docker image

Navigate to the `nginx-proxy` folder:

```console
$ cd nginx-proxy
```

Build the image:

```console
$ docker build . -t gitlab-proxy
```

### Step 3: Create the environment file

Copy the `.env.example` file:

```console
$ cp .env.example .env
```

The default configuration targets `gitlab.com`, but can be overriden to the URL
of your choice using the `GITLAB_URL` variable. For example: `GITLAB_URL=https://gitlab.mycompany.com`.

### Step 4: Set the API keys

Copy the `api_keys.conf.example` into a mount location on the host, for instance:

```console
$ cp api_keys.conf.example /tmp/api_keys.conf
```

Set the API keys in `api_keys.conf`:

- Generate an API key to be given to Echoes during the GitLab integration installation

```console
$ openssl rand -base64 18
oLAVcK2LAzfMpYXT10ymK1qL
```

- Generate a GitLab [Personal Token](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#create-a-personal-access-token)

The final content should resemble the following:

```txt
map $http_PRIVATE_TOKEN $gitlab_token {
    default "";

    "oLAVcK2LAzfMpYXT10ymK1qL" "glpat-fake-token";
}
```

### Step 5: Run the proxy

The proxy expects the file `api_keys.conf` to be mounted to `/etc/nginx/api_keys`.

The following command runs the proxy on port `8080`:

```console
docker run \
    --env-file .env \
    -v /tmp/api_keys.conf:/etc/nginx/api_keys/api_keys.conf:ro \
    -p 8080:80 gitlab-proxy
```

### Step 6: Call the GitLab API

Set the HTTP Header `PRIVATE-TOKEN` to the APi key set in the `api_keys.conf` file earlier, e,g `oLAVcK2LAzfMpYXT10ymK1qL`:

```console
curl --location --request GET 'http://0.0.0.0:8080/api/v4/groups/<REPLACE_ME>/members' \
    --header 'Content-Type: application/json' \
    --header 'PRIVATE-TOKEN: oLAVcK2LAzfMpYXT10ymK1qL'
```

### Step 7: Configure a GitLab integration within Echoes

Follow the [GitLab integration
documentation](https://docs.echoeshq.com/gitlab#iLeZv) to setup a new
integration pointing to your self-hosted GitLab API proxy, using the API key
generated in step 4 as your personal access token.

## Configuration with an upstream directive (Optional)

An upstream configuration may be necessary for on-premises GitLab instances.
The following steps describe how to use an upstream configuration with the
proxy.

### Step 1: Copy the `api_backends.conf` file

Copy the `api_backends.conf` file containing an example of upstream into a mount location on the host:

```console
$ cp api_backends.conf /tmp/api_backends.conf
```

### Step 2: Configure the upstream

Modify the copied `api_backends.conf` file in order to map the gitlab instance IP(s) of your choice.

### Step 3: Set the `GITLAB_URL` environment variable

Set the environment variable `GITLAB_URL` from the `.env` file as follow: `<protocol><upstream_name>` e,g `http://example`:

```txt
GITLAB_URL=http://example
```

### Step 4: Run the proxy

The proxy expects the file `api_backends.conf` to be mounted to `/etc/nginx/api_backends/api_backends.conf`:

```console
docker run \
    --env-file .env \
    -v /tmp/api_keys.conf:/etc/nginx/api_keys/api_keys.conf:ro \
    -v /tmp/api_backends.conf:/etc/nginx/api_backends/api_backends.conf:ro \
    -p 8080:80 gitlab-proxy
```

## Restricted access

The proxy is preconfigured to only accept connections from Echoes IP addresses.
If this turns out to be a problem for your particular deployment, comment the
corresponding lines in the `gitlab-proxy.conf` file:

```txt
  # Restricted to Echoes IPs
  # https://docs.echoeshq.com/echoes-ip-addresses
  allow 34.91.37.106;
  allow 34.90.193.154;
  deny all;
```

## Audit & troubleshooting

### API keys

The setting of the API keys is done in the `api_keys.conf` file. This file
should be mounted dynamically and not baked into the docker image.

### API routes

Allowed endpoints and methods are defined in `gitlab-api-routes` folder.

### HTTP headers

The proxy always adds the `X-Echoes-GitLab-Proxy-Version`.

### Access logs

Access logs are available for auditing in `/var/log/nginx/api_access.log`.
