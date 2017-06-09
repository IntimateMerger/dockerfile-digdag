# digdag-server

Dockerfile for [digdag](https://github.com/treasure-data/digdag)

The dockerfile is inspired by [this repository](https://github.com/myui/dockernized-digdag-server).

## How to use this image

You can used our [docker image](https://hub.docker.com/r/intimatemerger/digdag-server/) in Dockerhub.

```shell
docker pull intimatemerger/digdag-server:latest
docker run -p 65432:65432 -it intimatemerger/digdag-server:latest
```

### Parameters

Check [the command reference](http://docs.digdag.io/command_reference.html#server)

### Exanple

#### for Posgresql

It is recommended that you use PostgreSQL when using digdag in production.

```shell
docker pull intimatemerger/digdag-server:latest
docker run -p 65432:65432 -it intimatemerger/digdag-server:latest \
    -X database.type=posgresql \
    -X database.user=digdag \
    -X database.password=digdag \
    -X database.host=10.0.0.1 \
    -X database.port=5432 \
    -X database.database=digdag
```
