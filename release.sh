#!/bin/bash
set -e
echo $GITHUB_REF
VERSION="${GITHUB_REF##*/}"
echo "version: $VERSION"

# set git
if [[ -z "${CI}" ]]; then
  echo "Not in ci, use current user"
elif
  git config --local user.email "github-deplay-action@users.noreply.github.com"
  git config --local user.name "github-deplay-action"
fi

git checkout --orphan $VERSION
git add dist
git add action.yml
git add LICENSE
git commit -m "Release $VERSION from $GITHUB_SHA"
git push origin $VERSION

