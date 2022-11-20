# Livrovivo
Wrapper to deploy livebook service in Google Cloud Run and preserve state.

## Building

> cd src 

> docker build -t livrovivo -f wrapper.Dockerfile . 

## Testing locally
Run the following command to run the docker locally (when running in Google Run, auth happens via metadata service, no need to inject creds):

> export GOOGLE_APPLICATION_CREDENTIALS=</path/to/bucket/reader/creds.json>

> docker run -p 8080:8080 -p 8081:8081 \\\
>     -e BUCKET=<bucket_name> \\\
>     -e GOOGLE_APPLICATION_CREDENTIALS=/tmp/gc.key \\\
>     -v $GOOGLE_APPLICATION_CREDENTIALS:/tmp/gc.key:ro \\\
>     livrovivo