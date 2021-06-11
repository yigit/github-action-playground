#!/bin/bash
PUSH_BASE_SHA=${{ github.event.before }}
PR_BASE_SHA=${{ github.event.pull_request.base.sha }}

echo "$PUSH_BASE_SHA / $PR_BASE_SHA"
PR_NUMBER=$(echo $GITHUB_REF | awk 'BEGIN { FS = "/" } ; { print $3 }')
echo "PR NUMBER: $PR_NUMBER"

echo "event path: $GITHUB_EVENT_PATH"
echo "event path contents:"
cat $GITHUB_EVENT_PATH