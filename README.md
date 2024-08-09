# StaticJinjaPlusDocker

## Description

Docker images based on original project from [here](https://github.com/MrDave/StaticJinjaPlus).

## How to install

Download [docker](https://docs.docker.com/engine/install/) and log in to Docker Hub: 
```shell
docker login
```

## How to run

```shell
docker build -t <tag> -f <image>/<version>/Dockerfile .
```

### Run with a script

You need to have `templates` directory where you run the script. 
Otherwise [these]() templates will be used.
Check that your user is included in docker group, if not, run:
```shell
sudo usermod -aG docker <username>
```

Run:
```shell
./render.sh -base-image <image> -version <version>
```

Where `base-image` is either ubuntu or python-slim and `version` is either main (latest) or one presented in original project's tags.

There are 2 base images available:

- ubuntu
- python-slim

And 3 versions available:

- main
- 0.1.0
- 0.1.1

### Example

```shell
./render.sh -base-image python-slim -version 0.1.0
```

*By default, the base image is `ubuntu` and version is `main`.

## How to stop

Run:
```shell
docker stop static-jinja-plus_container
```

And delete:
```shell
docker rm static-jinja-plus_container
docker rmi static-jinja-plus_container:<tag>
```

## How to upload tags to docker hub

1. find your images' IDs

```shell
duke_duke@Duke-Duke:~$ docker images
REPOSITORY                    TAG             IMAGE ID       CREATED          SIZE
static-jinja-plus             0.1.0-python    7bb03fbb27f8   7 minutes ago    145MB
static-jinja-plus             latest-ubuntu   0d51b7d4af19   8 minutes ago    525MB
static-jinja-plus             latest-python   3fadc9b366ac   19 minutes ago   142MB
static-jinja-plus             0.1.1-python    1dbc88034fe0   29 hours ago     142MB
static-jinja-plus             0.1.0-ubuntu    49cbd425c788   2 weeks ago      522MB
static-jinja-plus             0.1.1-ubuntu    e5a2436ec376   3 weeks ago      519MB
```

2. Tag them with your docker username

```shell
docker tag 7bb03fbb27f8 <username>/static-jinja-plus:0.1.0-python
docker tag 0d51b7d4af19 <username>/static-jinja-plus:latest-ubuntu
docker tag 3fadc9b366ac <username>/static-jinja-plus:latest-python
docker tag 1dbc88034fe0 <username>/static-jinja-plus:0.1.1-python
docker tag 49cbd425c788 <username>/static-jinja-plus:0.1.0-ubuntu
docker tag e5a2436ec376 <username>/static-jinja-plus:0.1.1-ubuntu
```

3. Push

```shell
docker push <username>/static-jinja-plus:0.1.0-python
docker push <username>/static-jinja-plus:latest-ubuntu
docker push <username>/static-jinja-plus:latest-python
docker push <username>/static-jinja-plus:0.1.1-python
docker push <username>/static-jinja-plus:0.1.0-ubuntu
docker push <username>/static-jinja-plus:0.1.1-ubuntu
```