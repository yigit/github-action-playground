#!/bin/bash
COMPARE=$(jq '.compare' $GITHUB_EVENT_PATH)
# api.github.com/repos
COMPARE_API=$(echo $COMPARE | sed 's/github.com\//api.github.com\/repos\//g'| sed 's/"//g')
COMPARE_RESPONSE=$(curl -H "Accept: application/vnd.github.v3+json" $COMPARE_API)
# statuses we are interested in: added, modified, renamed
echo $COMPARE_RESPONSE | jq -r '.files | .[] | select(.status != "removed") | .filename'