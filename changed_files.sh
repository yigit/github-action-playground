#!/bin/bash
#echo "event path: $GITHUB_EVENT_PATH"
#echo "event path contents:"
COMPARE=$(jq '.compare' $GITHUB_EVENT_PATH)
#echo "compare url: $COMPARE"
# api.github.com/repos
COMPARE_API=$(echo $COMPARE | sed 's/github.com\//api.github.com\/repos\//g'| sed 's/"//g')
#echo "compare API url: $COMPARE_API"
COMPARE_RESPONSE=$(curl -H "Accept: application/vnd.github.v3+json" $COMPARE_API)
#echo "compare response: $COMPARE_RESPONSE"
# statuses we are interested in: added, modified, renamed
CHANGED_FILES=$(echo $COMPARE_RESPONSE | jq -r '.files | .[] | select(.status != "removed") | .filename')
LINE_DELIMITED_FILES=$(IFS='\n'; echo "${CHANGED_FILES[*]}" )
echo "listing files"
for file in "${LINE_DELIMITED_FILES[@]}"
do
  # remove quotes
  echo "file:"
  echo $file | sed 's/"//g' 
done
echo "done listing files"
echo $LINE_DELIMITED_FILES
echo "::set-output name=files::$LINE_DELIMITED_FILES"