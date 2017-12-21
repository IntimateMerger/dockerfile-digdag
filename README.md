# digdag

Dockerfile for [digdag](https://github.com/treasure-data/digdag)

## Supported tags and respective Dockerfile links

- `0.9.21`, `latest` ([Dockerfile](https://github.com/IntimateMerger/dockerfile-digdag/blob/master/Dockerfile))
- `0.9.21-debian`, `latest-debian` ([debian/Dockerfile](https://github.com/IntimateMerger/dockerfile-digdag/blob/master/debian/Dockerfile))
- `nginx` ([nginx/Dockerfile](https://github.com/IntimateMerger/dockerfile-digdag/blob/master/nginx/Dockerfile))
    - Nginx for reverse proxy.

## How to use this image

You can used our [docker image](https://hub.docker.com/r/intimatemerger/digdag/) in Dockerhub.

```shell
docker pull intimatemerger/digdag:latest
docker run -p 65432:65432 -it intimatemerger/digdag:latest
```

### Parameters

Check [the command reference](http://docs.digdag.io/command_reference.html#server)

### Exanple

#### for Posgresql

It is recommended that you use PostgreSQL when using digdag in production.

```shell
docker pull intimatemerger/digdag:latest
docker run -p 65432:65432 -it intimatemerger/digdag:latest server \
    --config /etc/digdag.properties \
    -X database.type=postgresql \
    -X database.user=digdag \
    -X database.password=digdag \
    -X database.host=10.0.0.1 \
    -X database.port=5432 \
    -X database.database=digdag
```
