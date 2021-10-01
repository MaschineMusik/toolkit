#!/usr/bin/env sh

# DOLBYIO_API_KEY=xxxxxx
# AUDIO_FILE=fur-elise.mp3

# start enhance job

JOB_ID=`curl --request POST \
     --url https://api.dolby.com/media/enhance \
     --header 'Accept: application/json' \
     --header 'Content-Type: application/json' \
     --header "x-api-key: ${DOLBYIO_API_KEY}" \
     --data '
{
   "audio" : {
      "loudness" : {
         "enable" : true,
         "peak_limit" : -1"
         "target_level" : -14
      },
      "music" : {
         "detection" : {
            "enable" : true
         }
      }
   },
   "content" : {
      "type" : "music"
   },
   "input" : "dlb://in/'${AUDIO_FILE}'",
   "output" : "dlb://out/'${AUDIO_FILE}'"
}
'| jq -r '.job_id' `

echo ${JOB_ID}