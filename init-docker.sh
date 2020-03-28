#!/bin/bash

set -e

ENV_FILE=".env"
USER_ID=$(id -u)
GROUP_ID=$(id -g)

if [ "${USER_ID}" = 0 ]; then
  echo "ERROR: This script must not be called by root!"
  exit 1
fi

touch "${ENV_FILE}"

grep -q "DOCKER_UID=" "${ENV_FILE}" &&
  sed -i "s/DOCKER_UID=.*/DOCKER_UID=${USER_ID}/g" "${ENV_FILE}" ||
  echo "DOCKER_UID=${USER_ID}" >>"${ENV_FILE}"

grep -q "DOCKER_GID=" "${ENV_FILE}" &&
  sed -i "s/DOCKER_GID=.*/DOCKER_GID=${GROUP_ID}/g" "${ENV_FILE}" ||
  echo "DOCKER_GID=${GROUP_ID}" >>"${ENV_FILE}"
