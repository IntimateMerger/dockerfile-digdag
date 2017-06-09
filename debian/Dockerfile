FROM java:8

ENV DIGDAG_VERSION=0.9.12 \
    DIGDAG_HOME=/var/lib/digdag

RUN curl -o /usr/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-$DIGDAG_VERSION" && \
    chmod +x /usr/bin/digdag && \
    useradd -b $DIGDAG_HOME -c 'digdag user' -s /sbin/nologin digdag && \
        mkdir -p $DIGDAG_HOME/logs/tasks $DIGDAG_HOME/logs/server && \
        chown -R digdag.digdag $DIGDAG_HOME && \
    apt-get update && \
        apt-get install -y ca-certificates groff less jq python-pip && \
        apt-get clean && \
        rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* && \
    pip install awscli==1.11.101 boto3==1.4.4

COPY digdag.properties /etc/digdag.properties

USER digdag

WORKDIR /var/lib/digdag

EXPOSE 65432
ENTRYPOINT ["/bin/sh", "/usr/bin/digdag", "server", "--bind", "0.0.0.0", "--port", "65432", "--config", "/etc/digdag.properties"]
CMD ["-X", "database.type=memory"]
