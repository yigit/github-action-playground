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
echo "removing all files"
git rm --cached -r .
git status
echo "add dist"
git add dist
git status
echo "add action.yml"
git add action.yml
git status
echo "add license"
git add LICENSE
git status
git commit -m "Release $VERSION from $GITHUB_SHA"
git push origin $VERSION -f

