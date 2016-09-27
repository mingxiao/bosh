#!/bin/sh

set -e
set -u

export VERSION=$( cat version/number | sed 's/\.0$//;s/\.0$//' )

mkdir -p ~/.ssh
cat > ~/.ssh/config <<EOF
StrictHostKeyChecking no
LogLevel quiet
EOF

cd bosh-src

git tag stable-$VERSION

git pull

