FROM alpine:3.10.1

# Install Docker client
ARG DOCKER_CLI_VERSION="18.06.3-ce"
ENV DOWNLOAD_URL="https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_CLI_VERSION.tgz"

# from https://github.com/aptible/supercronic/releases
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.9/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=5ddf8ea26b56d4a7ff6faecdd8966610d5cb9d85

RUN apk --update add --no-cache \
    ca-certificates \
    curl \
    tini \
    lftp \
    && mkdir -p /tmp/download \
    && curl -L $DOWNLOAD_URL | tar -xz -C /tmp/download \
    && mv /tmp/download/docker/docker /usr/local/bin/ \
    && rm -rf /tmp/download \
    # install supercronic (from https://github.com/aptible/supercronic/releases)
    && curl -fsSLO "$SUPERCRONIC_URL" \
    && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
    && chmod +x "$SUPERCRONIC" \
    && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
    && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic \
    && rm -rf /var/cache/apk/ \
    # Do not validate SSL certs, for self signed of NAS
    && echo "set ssl:verify-certificate no" >> /etc/lftp.conf

EXPOSE 9080
ENTRYPOINT [ "/sbin/tini", "--" ]
CMD [ "/usr/local/bin/supercronic", \
    "--prometheus-listen-address", ":9080", \
     "/homelab/cron/crontab" ]