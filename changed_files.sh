#!/bin/bash
#echo "event path: $GITHUB_EVENT_PATH"
#echo "event path contents:"
COMPARE=$(jq '.compare' $GITHUB_EVENT_PATH)
#echo "compare url: $COMPARE"
# api.github.com/repos
COMPARE_API=$(echo $COMPARE | sed 's/github.com\//api.github.com\/repos\//g'| sed 's/"//g')
#echo "compare API url: $COMPARE_API"
COMPARE_RESPONSE=$(curl -H "Accept: application/vnd.github.v3+json" $COMPARE_API)
# COMPARE_RESPONSE=$(cat compare.json)
echo "compare response: $COMPARE_RESPONSE"
# statuses we are interested in: added, modified, renamed
CHANGED_FILES=`echo $COMPARE_RESPONSE | jq -r '.files | .[] | select(.status != "removed") | .filename'`
echo "changed files: $CHANGED_FILES"
# echo "changed files expanded: $CHANGED_FILES"
# LINE_DELIMITED_FILES=$(IFS=' '; echo "${CHANGED_FILES[*]}" )
# echo "listing files"
# echo "changed file count: ${#CHANGED_FILES[@]}"
# for file in "${CHANGED_FILES[@]}"
# do
#   # remove quotes
#   echo "file: $file"
#   echo $file | sed 's/"//g' 
# done
# echo "done listing files"
# echo "line delimited files: $LINE_DELIMITED_FILES"
echo "set output:"
echo "::set-output name=files::'$CHANGED_FILES'"