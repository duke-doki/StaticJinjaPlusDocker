# StaticJinjaPlusDocker

## Description

Docker images based on original project from [here](https://github.com/MrDave/StaticJinjaPlus).

## How to install

Download [docker](https://docs.docker.com/engine/install/) and log in to Docker Hub: 
```shell
docker login
```

## How to run

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

*By default the base image is `ubuntu` and version is `main`.

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