# dolby.io

[Dolby](https://dolby.io/) offers on-line audio tools incliuding the [Media Analyze API ](https://docs.dolby.io/media-apis/docs/quick-start-to-analyzing-media) 


For API usage see : [Dolby API](../../vendors/dolby/README.md)

## Analyzing Media

```bash
curl --request POST \
     --url https://api.dolby.com/media/analyze \
     --header 'Accept: application/json' \
     --header 'Content-Type: application/json' \
     --header "x-api-key: ${DOLBYIO_API_KEY}" \
     --data '
{
     "loudness": {
          "profile": "service_spotify"
     },
     "content": {
          "silence": {
               "threshold": -60,
               "duration": 2
          },
          "type": "music"
     },
     "input": "dlb://in/example.wav",
     "output": "dlb://out/example.json"
}
'
```

## Example Result

### Before Enhancement
```json
{
    "media_info": {
        "container": {
            "kind": "wav",
            "duration": 48.0,
            "bitrate": 2119691,
            "size": 12718144
        },
        "audio": {
            "codec": "pcm",
            "bit_depth": 24,
            "channels": 2,
            "sample_rate": 44100,
            "duration": 48.0,
            "bitrate": 2116800
        }
    },
    "processed_region": {
        "start": 0.0,
        "end": 48.0,
        "audio": {
            "clipping": {
                "num_sections": 0,
                "sections": []
            },
            "loudness": {
                "measured": -16.53,
                "range": 14.76,
                "gating_mode": "level",
                "sample_peak": -3.05,
                "true_peak": -3.03,
                "time_series": [
                    [
                        0.0,
                        -120.0,
                        -25.64,
                        -25.64
                    ],
...

                    [
                        47.0,
                        -17.38,
                        -47.7,
                        -47.68
                    ]
                ]
            },
            "validation": {
                "loudness": {
                    "pass": false,
                    "detail": "measured loudness -16.53 outside range specified [-15,-13]"
                }
            },
            "bandwidth": 7579,
            "noise": {
                "snr_average": 76.91,
                "level_average": -100.15
            },
            "music": {
                "percentage": 100.0,
                "num_sections": 1
            },
            "speech": {
                "percentage": 0.0,
                "num_sections": 0
            },
            "silence": {
                "percentage": 0.0,
                "num_sections": 0,
                "sections": []
            }
        }
    }
}
```

### Enhanced

```json
{
    "media_info": {
        "container": {
            "kind": "wav",
            "duration": 48.0,
            "bitrate": 2116817,
            "size": 12700904
        },
        "audio": {
            "codec": "pcm",
            "bit_depth": 24,
            "channels": 2,
            "channel_order": "L R",
            "sample_rate": 44100,
            "duration": 48.0,
            "bitrate": 2116800
        }
    },
    "processed_region": {
        "start": 0.0,
        "end": 48.0,
        "audio": {
            "clipping": {
                "num_sections": 0,
                "sections": []
            },
            "loudness": {
                "measured": -8.12,
                "range": 12.13,
                "gating_mode": "level",
                "sample_peak": -0.96,
                "true_peak": -0.96,
                "time_series": [
                    [
                        0.0,
                        -120.0,
                        -15.67,
                        -15.66
                    ],
...
                    [
                        47.0,
                        -8.19,
                        -36.83,
                        -36.81
                    ]
                ]
            },
            "validation": {
                "loudness": {
                    "pass": false,
                    "detail": "measured loudness -8.12 outside range specified [-15,-13]; measured true peak -0.96 exceeds maximum specified (-1)"
                }
            },
            "bandwidth": 7579,
            "noise": {
                "snr_average": 75.18,
                "level_average": -89.74
            },
            "music": {
                "percentage": 100.0,
                "num_sections": 1
            },
            "speech": {
                "percentage": 0.0,
                "num_sections": 0
            },
            "silence": {
                "percentage": 0.0,
                "num_sections": 0,
                "sections": []
            }
        }
    }
}

```