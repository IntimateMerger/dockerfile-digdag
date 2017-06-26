FROM java:8

LABEL maintainer "mats116 <mats.kazuki@gmail.com>"

ENV DIGDAG_VERSION=0.9.12 \
    DIGDAG_HOME=/var/lib/digdag \
    DOCKER_VERSION=17.03.1-ce

COPY requirements.txt requirements.txt

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
    # Python
    pip install -r requirements.txt

COPY digdag.properties /etc/digdag.properties

USER digdag

WORKDIR /var/lib/digdag

EXPOSE 65432
CMD digdag server --config /etc/digdag.properties --memory
