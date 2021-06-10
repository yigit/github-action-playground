#!/bin/bash
PR_NUMBER=$(echo $GITHUB_REF | awk 'BEGIN { FS = "/" } ; { print $3 }')
echo "PR NUMBER: $PR_NUMBER"

echo "event path: $GITHUB_EVENT_PATH"
echo "event path contents:"
cat $GITHUB_EVENT_PATH