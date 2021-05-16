#!/bin/bash
set -e
echo $GITHUB_REF
VERSION="${GITHUB_REF##*/}"
echo "version: $VERSION"
git checkout --orphan $VERSION
git add dist
git add action.yml
git add LICENSE
git commit -m "Release $VERSION from $GITHUB_SHA"
git push origin $VERSION

