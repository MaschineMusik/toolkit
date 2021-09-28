# dolby.io

[Dolby](https://dolby.io/) offers on-line audio tools incliuding the [Media Enhance API ](https://docs.dolby.io/media-apis/reference/media-enhance-overview) 


## API Key

```bash
export DOLBYIO_API_KEY=xxxxxx
```


## Upload

Get upload URL
```bash
curl -X POST https://api.dolby.com/media/input \
     --header "x-api-key: ${DOLBYIO_API_KEY}" \
     --data '
{
    "url": "dlb://in/example.wav"
}
'
```

that will return a pre-signed URL that you can upload to

```bash
export PRE_SIGNED_URL="https://media-api-proxfyprug.s3-accelerate.amazonaws.com/xxxxx/in/example.wav?
X-Amz-Algorithm=AWS4-HMAC-SHA256&
X-Amz-Credential=xxxxx&
X-Amz-Date=xxxxx&
X-Amz-Expires=3600&X-Amz-Security-Token=xxxxx&
X-Amz-Signature=xxxxx&
X-Amz-SignedHeaders=host"
```

Now you can upload

```bash
curl -X PUT ${PRE_SIGNED_URL} -T ./example.wav
```

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

eg
```json
{"job_id":"3xxxxxx-xxxx-xxxx-xxxx-xxxxxx"}
```

```bash
export DOLBYIO_JOB_ID="xxxxxx-xxxx-xxxx-xxxx-xxxxxx"
```

### Query job status
```bash
curl -X GET "https://api.dolby.com/media/enhance?job_id=$DOLBYIO_JOB_ID" \
     --header "x-api-key: $DOLBYIO_API_KEY"
```
This returns:
```json
{"path":"/media/enhance","status":"Success","progress":100,"api_version":"v1.1.2","result":{}}
```

## Download

```bash
curl  -X GET "https://api.dolby.com/media/output?url=dlb://out/example-enhanced.wav" \
      -O -L \
      --header "x-api-key: $DOLBYIO_API_KEY"
```

This will save the file locally