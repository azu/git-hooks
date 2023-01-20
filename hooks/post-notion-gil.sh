#!/bin/bash

# GIL Script
# Post commit log to Notin

GIT_COMMIT_HASH="$1"
GIT_COMMIT_MSG="$2"
GIT_REPO_HTTP_URL="$3"

declare GIL_NOTION_DAIRY_DATABASE_ID
declare GIL_NOTION_GIL_DATABASE_ID
declare GIL_NOTION_GIL_API_TOKEN

# Require 1Password: "GIL_NOTION"
declare scriptDir
declare DOT_ENV
scriptDir=$(cd $(dirname ${BASH_SOURCE:-$0}) || exit; pwd)
DOT_ENV="${scriptDir}/../.env"
export $(grep -v '^#' "${DOT_ENV}" | xargs)

# today YYYY/MM/DD
declare TODAY_YYYYMMDD
TODAY_YYYYMMDD=$(date '+%Y/%m/%d')
echo "TODAY_YYYYMMDD: ${TODAY_YYYYMMDD}"
# Get Today Page ID from Notion
declare NOTION_DAIRY_PAGE_ID
declare NOTION_DAIRY_PAGE_RESPONSE
declare NOTION_DAIRY_PAYLOAD=$(cat <<EOF
{
  "filter": {
    "property": "Name",
    "title": {
      "equals": "${TODAY_YYYYMMDD}"
    }
  }
}
EOF
)
NOTION_DAIRY_PAGE_RESPONSE=$(curl -s -X POST https://api.notion.com/v1/databases/${GIL_NOTION_DAIRY_DATABASE_ID}/query \
  -H "Authorization: Bearer ${GIL_NOTION_GIL_API_TOKEN}" \
  -H "Content-Type: application/json" \
  -H "Notion-Version: 2022-02-22" \
  --data "${NOTION_DAIRY_PAYLOAD}")
NOTION_DAIRY_PAGE_ID=$(echo "${NOTION_DAIRY_PAGE_RESPONSE}" | jq -r '.results[0].id')
echo "NOTION_DAIRY_PAGE_ID: ${NOTION_DAIRY_PAGE_ID}";

NOTION_GIL_PAYLOAD=$(cat <<EOF
{
  "parent": { "database_id": "${GIL_NOTION_GIL_DATABASE_ID}" },
  "properties": {
    "Message": {
      "title": [
        {
          "text": {
            "content": "${GIT_COMMIT_MSG}"
          }
        }
      ]
    },
    "Hash": {
      "rich_text": [{
        "text": {
          "content": "${GIT_COMMIT_HASH}"
        }
      }]
    },
    "Repo": {
      "url": "${GIT_REPO_HTTP_URL}"
    },
    "🌟 Daily": {
      "relation": [
        {
          "id": "${NOTION_DAIRY_PAGE_ID}"
        }
      ]
    }
  }
}
EOF
)
curl -s -X POST https://api.notion.com/v1/pages \
  -H "Authorization: Bearer ${GIL_NOTION_GIL_API_TOKEN}" \
  -H "Content-Type: application/json" \
  -H "Notion-Version: 2022-02-22" \
  --data "${NOTION_GIL_PAYLOAD}"