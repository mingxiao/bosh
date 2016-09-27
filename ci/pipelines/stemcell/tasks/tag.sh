#!/bin/sh

set -e
set -u

export VERSION=$( cat version/number | sed 's/\.0$//;s/\.0$//' )

cd bosh-src

git tag stable-$VERSION

git pull

