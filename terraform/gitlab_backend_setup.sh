#!/bin/bash
# Use this script to use GitLab backend in your development environment

if [[ -z "$GITLAB_TOKEN" ]]
then
  echo 'You shall set a valid $GITLAB_TOKEN'
  exit 1
fi

# TODO: replace 3 next variables
PROJECT_PATH=${CI_PROJECT_PATH:-to-be-continuous/samples/terraform-ansible-on-aws}
ENV_NAME=${TF_ENV_NAME:-dev}

CI_API_V4_URL=https://gitlab.com/api/v4
CI_PROJECT_ID=${PROJECT_PATH//\//%2f}

TF_HTTP_ADDRESS="${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/terraform/state/$ENV_NAME"
TF_HTTP_LOCK_ADDRESS="${TF_HTTP_ADDRESS}/lock"
TF_HTTP_LOCK_METHOD="POST"
TF_HTTP_UNLOCK_ADDRESS="${TF_HTTP_ADDRESS}/lock"
TF_HTTP_UNLOCK_METHOD="DELETE"
TF_HTTP_USERNAME="gitlab-token"
TF_HTTP_RETRY_WAIT_MIN="5"

terraform -v

terraform init \
    -reconfigure \
    -backend-config=address="${TF_HTTP_ADDRESS}" \
    -backend-config=lock_address="${TF_HTTP_LOCK_ADDRESS}" \
    -backend-config=unlock_address="${TF_HTTP_UNLOCK_ADDRESS}" \
    -backend-config=username="${TF_HTTP_USERNAME}" \
    -backend-config=password="${GITLAB_TOKEN}" \
    -backend-config=lock_method="${TF_HTTP_LOCK_METHOD}" \
    -backend-config=unlock_method="${TF_HTTP_UNLOCK_METHOD}" \
    -backend-config=retry_wait_min="${TF_HTTP_RETRY_WAIT_MIN}"
