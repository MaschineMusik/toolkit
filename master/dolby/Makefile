INPUT_FILE=in/fur-elise.mp3

url:
	curl -X POST https://api.dolby.com/media/input \
		--header "x-api-key: ${DOLBYIO_API_KEY}" \
		--data '
			{
				"url": "dlb://in/fur-elise.mp3"
			}
		' 