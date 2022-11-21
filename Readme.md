# Livrovivo
Wrapper to deploy [livebook](https://github.com/livebook-dev/livebook) service in Google Cloud Run and preserve state.
Based on https://cloud.google.com/run/docs/tutorials/network-filesystems-fuse.

## Deploying
Create the following resources on Google Cloud:
- a bucket (<bucket_name>).
- a secret (<login_password>).
- a service (<service_account>) account with restricted permissions to r/w the bucket and access to read the secret.

Then deploy the container directly:
```console
cd src 
gcloud beta run deploy <app_name> --source . \\\
    --execution-environment gen2 \\\
    --allow-unauthenticated --port=8080 \\\
    --session-affinity \\\
    --cpu=1 --memory=1Gi \\\
    --min-instances=0 --max-instances=1 \\\
    --concurrency=200 --timeout=600 \\\
    --service-account <service_account> \\\
    --update-env-vars BUCKET=<bucket_name> \\\
    --update-secrets=LIVEBOOK_PASSWORD=<login_password>:1
```

## Testing locally
Before deploying directly to Google Cloud Run, one can build and test it locally.

### Building locally

```console
cd src 
docker build -t livrovivo -f Dockerfile . 
```
### Testing locally
Run the following command to run the docker locally (when running in Google Run, auth happens via metadata service, no need to inject creds):

```console
export GOOGLE_APPLICATION_CREDENTIALS=</path/to/bucket/reader/creds.json>
```
```console
docker run -p 8080:8080 -p 8081:8081 \\\
    -e BUCKET=<bucket_name> \\\
    -e GOOGLE_APPLICATION_CREDENTIALS=/tmp/gc.key \\\
    -v $GOOGLE_APPLICATION_CREDENTIALS:/tmp/gc.key:ro \\\
    livrovivo
```