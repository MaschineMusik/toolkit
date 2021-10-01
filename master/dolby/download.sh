#!/usr/bin/env sh

# DOLBYIO_API_KEY=xxxxxx
# AUDIO_FILE=fur-elise.mp3

curl -X GET "https://api.dolby.com/media/output?url=dlb://out/${AUDIO_FILE}" \
     --create-dirs \
     --output out/${AUDIO_FILE} \
     -L \
     --header "x-api-key: ${DOLBYIO_API_KEY}"