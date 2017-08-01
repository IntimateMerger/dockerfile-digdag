FROM java:8-alpine

LABEL maintainer "mats116 <mats.kazuki@gmail.com>"

ENV DIGDAG_VERSION=0.9.13 \
    DIGDAG_HOME=/var/lib/digdag \
    DOCKER_VERSION=17.06.0-ce

COPY requirements.txt requirements.txt

RUN apk --no-cache add curl && \
    curl -o /usr/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-$DIGDAG_VERSION" && \
    chmod +x /usr/bin/digdag && \
    adduser -h $DIGDAG_HOME -g 'digdag user' -s /sbin/nologin -D digdag && \
    mkdir -p $DIGDAG_HOME/logs/tasks $DIGDAG_HOME/logs/server && \
    chown -R digdag.digdag $DIGDAG_HOME && \
    apk --no-cache add tzdata ca-certificates groff less bash jq python py-pip py-setuptools && \
    rm -rf /var/cache/apk/* && \
    # Docker
    curl "https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz" | tar xvz -C /tmp && \
    mv /tmp/docker/* /usr/bin/ && \
    addgroup -g 497 docker && \
    adduser digdag docker && \
    # Python
    pip --no-cache-dir install -r requirements.txt

COPY digdag.properties /etc/digdag.properties

USER digdag

WORKDIR /var/lib/digdag

EXPOSE 65432
ENTRYPOINT ["/bin/sh", "/usr/bin/digdag"]
CMD ["server", "--config", "/etc/digdag.properties", "--memory"]
