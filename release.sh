#!/bin/bash
set -e
echo $GITHUB_REF
VERSION="${GITHUB_REF##*/}"
echo "version: $VERSION"
