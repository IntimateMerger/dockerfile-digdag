FROM java:8-alpine

ENV DIGDAG_VERSION=0.9.12 \
    DIGDAG_HOME=/var/lib/digdag \
    DOCKER_VERSION=17.03.1-ce

RUN apk --no-cache add curl && \
    curl -o /usr/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-$DIGDAG_VERSION" && \
    chmod +x /usr/bin/digdag && \
    adduser -h $DIGDAG_HOME -g 'digdag user' -s /sbin/nologin -D digdag && \
        mkdir -p $DIGDAG_HOME/logs/tasks $DIGDAG_HOME/logs/server && \
        chown -R digdag.digdag $DIGDAG_HOME && \
    apk --no-cache add ca-certificates groff less bash jq python py-pip py-setuptools && \
        rm -rf /var/cache/apk/* && \
    pip --no-cache-dir install awscli==1.11.101 boto3==1.4.4 && \
    curl "https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz" | tar xvz -C /usr/bin

COPY digdag.properties /etc/digdag.properties

USER digdag

WORKDIR /var/lib/digdag

EXPOSE 65432
ENTRYPOINT ["/bin/sh", "/usr/bin/digdag", "server", "--bind", "0.0.0.0", "--port", "65432", "--config", "/etc/digdag.properties"]
CMD ["-X", "database.type=memory"]
