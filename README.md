Open a SSH tunnel to remote `HOST` on `PORT` and expose it on container port `22`. `SSH_PRIVATE_KEY` needs to be provided. To create a tunnel from local port `12345` to `example.org:12345` using an *unencrypted* private key stored at `~/.ssh/id_rsa` the following command may be used:

```sh
docker run --rm -it \
  -e HOST=example.org \
  -e PORT=12345 \
  -e SSH_PRIVATE_KEY=$(cat ~/.ssh/id_rsa) \
  -p 12345:22 \
  macheins/ssh-tunnel
```

By mounting a volume to `/root/.ssh` keys, configs and/or known hosts may be provided. The following defaults apply, if not set elsewhere, and may be overridden using those environment variables:

```sh
SSH_ALIVE_INTERVAL=60
SSH_USER=root
SSH_PORT=22
SSH_KNOWN_HOSTS=$(ssh-keyscan -H $HOST)
```

Provided environment variables always take precedence over any other config.
