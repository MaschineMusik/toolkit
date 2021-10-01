#!/usr/bin/env sh

# DOLBYIO_API_KEY=xxxxxx
# AUDIO_FILE=fur-elise.mp3

# get_upload_url

PRE_SIGNED_URL=`curl -X POST https://api.dolby.com/media/input \
     --header "x-api-key: ${DOLBYIO_API_KEY}" \
     --data '
        {
            "url": "dlb://in/'${AUDIO_FILE}'"
        }
    ' | jq -r '.url' `

# upload 

curl -X PUT ${PRE_SIGNED_URL} -T in/${AUDIO_FILE}