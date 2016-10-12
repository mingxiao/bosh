#!/usr/bin/env bash

set -eux

export ROOT_PATH=$PWD
PROMOTED_REPO=$PWD/bosh-promote-src

mv bosh-cli/bosh-cli-*-linux-amd64 bosh-cli/bosh-cli
export GO_CLI_PATH=$ROOT_PATH/bosh-cli/bosh-cli
chmod +x $GO_CLI_PATH

export DEV_RELEASE_PATH=$ROOT_PATH/bosh-dev-release/bosh*.tgz

git clone ./bosh-src $PROMOTED_REPO
cd $PROMOTED_REPO
git status

cd release

cat >> config/private.yml <<EOF
---
blobstore:
  provider: s3
  options:
    access_key_id: "$BLOBSTORE_ACCESS_KEY_ID"
    secret_access_key: "$BLOBSTORE_SECRET_ACCESS_KEY"
EOF

$GO_CLI_PATH finalize-release $DEV_RELEASE_PATH

git add -A
git status

git config --global user.email "mxiao@pivotal.io"
git config --global user.name "Ming Xiao"

git commit -m 'Adding final release via concourse'
