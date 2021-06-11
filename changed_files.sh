#!/bin/bash
PUSH_BASE_SHA=${{ github.event.before }}
PR_BASE_SHA=${{ github.event.pull_request.base.sha }}

echo "$PUSH_BASE_SHA / $PR_BASE_SHA"
PR_NUMBER=$(echo $GITHUB_REF | awk 'BEGIN { FS = "/" } ; { print $3 }')
echo "PR NUMBER: $PR_NUMBER"

echo "event path: $GITHUB_EVENT_PATH"
echo "event path contents:"
COMPARE=$(jq '.compare' $GITHUB_EVENT_PATH)
echo "compare: $COMPARE"
# api.github.com/repos
COMPARE_API=$(echo $COMPARE | sed 's/github.com\//api.github.com\/repos\//g'| sed 's/"//g')
echo $COMPARE_API
COMPARE=$(curl -v -H "Accept: application/vnd.github.v3+json" $COMPARE_API)
echo "compare $COMPARE"
# statuses we are interested in: added, modified, renamed
FILES=$(echo $COMPARE | jq '.files | .[] | select(.status != "removed") | .filename')
echo $FILES

for file in "${FILES[@]}"
do
  echo "file: ${file}"
done