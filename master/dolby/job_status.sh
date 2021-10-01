#!/usr/bin/env sh

# DOLBYIO_API_KEY=xxxxxx
# DOLBYIO_JOB_ID=e70a2240-9fe6-4852-b048-1dca1b8d8ef9

curl -X GET "https://api.dolby.com/media/enhance?job_id=$DOLBYIO_JOB_ID" \
     --header "x-api-key: $DOLBYIO_API_KEY"

