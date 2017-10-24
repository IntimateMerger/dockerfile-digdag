FROM jruby:9.1.12-jdk

LABEL maintainer "mats116 <mats.kazuki@gmail.com>"

ENV DIGDAG_VERSION=0.9.20 \
    DIGDAG_HOME=/var/lib/digdag \
    DOCKER_VERSION=17.09.0-ce

RUN curl -o /usr/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-$DIGDAG_VERSION" && \
    chmod +x /usr/bin/digdag && \
    useradd -b $DIGDAG_HOME -c 'digdag user' -s /sbin/nologin digdag && \
    mkdir -p $DIGDAG_HOME/logs/tasks $DIGDAG_HOME/logs/server && \
    chown -R digdag.digdag $DIGDAG_HOME && \
    apt-get update && \
    apt-get install -y ca-certificates groff less jq python python-pip python-dev libssl-dev && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* && \
    # Docker
    curl "https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz" | tar xvz -C /tmp && \
    mv /tmp/docker/* /usr/bin/ && \
    groupadd -g 497 docker && \
    gpasswd -a digdag docker && \
    # Embulk
    curl --create-dirs -o /usr/bin/embulk -L "https://dl.embulk.org/embulk-latest.jar" && \
    chmod +x /usr/bin/embulk && \
    # Python
    pip install awscli boto3

COPY digdag.properties /etc/digdag.properties

USER digdag

# Embulk Plugins
RUN embulk gem install \
        embulk-input-s3 \
        embulk-output-s3 \
        embulk-input-gcs \
        embulk-output-gcs \
        embulk-input-bigquery \
        embulk-output-bigquery

WORKDIR /var/lib/digdag

EXPOSE 65432
ENTRYPOINT ["/bin/sh", "/usr/bin/digdag"]
CMD ["server", "--config", "/etc/digdag.properties", "--memory"]
