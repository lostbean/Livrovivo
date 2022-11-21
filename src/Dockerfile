FROM livebook/livebook:latest

RUN set -e; \
    apt-get update -y && apt-get install -y \
        tini curl gnupg lsb-release; \
    gcsFuseRepo=gcsfuse-`lsb_release -c -s`; \
    echo "deb http://packages.cloud.google.com/apt $gcsFuseRepo main" | \
        tee /etc/apt/sources.list.d/gcsfuse.list; \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
        apt-key add -; \
    apt-get update; \
    apt-get install -y gcsfuse; \
    apt-get clean

ENV LIVEBOOK_HOME /mnt/data
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY wrapper_run.sh $APP_HOME/wrapper_run.sh
RUN chmod +x $APP_HOME/wrapper_run.sh

# Use tini to manage zombie processes and signal forwarding
# https://github.com/krallin/tini
ENTRYPOINT ["/usr/bin/tini", "--"] 

# Pass the startup script as arguments to Tini
CMD ["/app/wrapper_run.sh"]