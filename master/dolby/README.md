# dolby.io

[Dolby](https://dolby.io/) offers on-line audio tools incliuding the [Media Enhance API ](https://docs.dolby.io/media-apis/reference/media-enhance-overview) 



For API usage see : [Dolby API](../../vendors/dolby/README.md)

## Enhance

```bash
curl --request POST \
     --url https://api.dolby.com/media/enhance \
     --header 'Accept: application/json' \
     --header 'Content-Type: application/json' \
     --header "x-api-key: ${DOLBYIO_API_KEY}" \
     --data '
{
     "content": {
          "type": "music"
     },
     "audio": {
          "loudness": {
               "enable": true,
               "target_level": -8
          },
          "music": {
               "detection": {
                    "enable": true
               }
          }
     },
     "input": "dlb://in/example.wav",
     "output": "dlb://out/example-enhanced.wav"
}
'

```
This will start a job and return a Job Id

# Scripts

convention
- input filename in `./in`
- output will be downloaded to `./out`

```bash
export DOLBYIO_API_KEY=xxx
export AUDIO_FILE=fur-elise.mp3

./upload.sh 
export DOLBYIO_JOB_ID=$(./enhance.sh)
./job_status.sh
./download.sh 
```