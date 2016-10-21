#!/bin/sh
set -e

if [ ! -z ${SSH_PRIVATE_KEY+x} ]; then
  echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
  chmod 0600 ~/.ssh/id_rsa
fi

if [ -z ${SSH_KNOWN_HOSTS+x} ]; then
  if [ ! -f "/root/.ssh/known_hosts" ]; then
    echo "$(ssh-keyscan -H $HOST)" > ~/.ssh/known_hosts
  fi
else
  echo "$SSH_KNOWN_HOSTS" > ~/.ssh/known_hosts
fi

ssh -vN \
  ${SSH_ALIVE_INTERVAL+"-o ServerAliveInterval=$SSH_ALIVE_INTERVAL"} \
  -l ${SSH_USER:-root} \
  $HOST \
  -p ${SSH_PORT:-22} \
  -L *:22:localhost:$PORT
