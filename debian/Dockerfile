FROM java:8

LABEL maintainer "mats116 <mats.kazuki@gmail.com>"

ENV DIGDAG_VERSION=0.9.12 \
    DIGDAG_HOME=/var/lib/digdag \
    DOCKER_VERSION=17.03.1-ce

RUN curl -o /usr/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-$DIGDAG_VERSION" && \
    chmod +x /usr/bin/digdag && \
    useradd -b $DIGDAG_HOME -c 'digdag user' -s /sbin/nologin digdag && \
        mkdir -p $DIGDAG_HOME/logs/tasks $DIGDAG_HOME/logs/server && \
        chown -R digdag.digdag $DIGDAG_HOME && \
    apt-get update && \
        apt-get install -y ca-certificates groff less jq python-pip && \
        apt-get clean && \
        rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* && \
    pip install awscli==1.11.101 boto3==1.4.4 && \
    curl "https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz" | tar xvz -C /tmp && \
        mv /tmp/docker/* /usr/bin/

ENV AS_TOOLS_VERSION=3.13.0.1
RUN curl "http://artifacts.aerospike.com/aerospike-tools/$AS_TOOLS_VERSION/aerospike-tools-$AS_TOOLS_VERSION-debian8.tgz" | tar xvz -C /tmp && \
    dpkg -i /tmp/aerospike-tools-$AS_TOOLS_VERSION-debian8/aerospike-tools-$AS_TOOLS_VERSION.debian8.x86_64.deb && \
    rm -rf /tmp/aerospike-tools-$AS_TOOLS_VERSION-debian8

COPY digdag.properties /etc/digdag.properties

USER digdag

WORKDIR /var/lib/digdag

EXPOSE 65432
ENTRYPOINT ["/bin/sh", "/usr/bin/digdag", "server", "--bind", "0.0.0.0", "--port", "65432", "--config", "/etc/digdag.properties"]
CMD ["-X", "database.type=memory"]
