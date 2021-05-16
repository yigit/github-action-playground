#!/bin/bash
set -e
echo $GITHUB_REF
VERSION="${GITHUB_REF##*/}"
echo "version: $VERSION"

if [[ -z "${VERSION}" ]]; then
   echo "no version found, cancel OP"
   exit 1
fi
# set git
if [[ -z "${CI}" ]]; then
  echo "Not in ci, use current user"
else
  git config --local user.email "github-deplay-action@users.noreply.github.com"
  git config --local user.name "github-deplay-action"
fi

git checkout --orphan $VERSION
git restore .
git add dist
git add action.yml
git add LICENSE
git commit -m "Release $VERSION from $GITHUB_SHA"
git push origin $VERSION

