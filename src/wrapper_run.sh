#!/usr/bin/env bash
set -eo pipefail

# Create mount directory for service
mkdir -p $LIVEBOOK_HOME

echo "Mounting GCS Fuse."
# Add these if more debug info is needed: --foreground --debug_fs --debug_http -o nonempty
gcsfuse --debug_gcs --debug_fuse $BUCKET $LIVEBOOK_HOME 
echo "Mounting completed."

# Start livebook
exec  /app/bin/livebook start &

# Exit immediately when one of the background processes terminate.
wait -n