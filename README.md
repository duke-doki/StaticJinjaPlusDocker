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

Run:
```shell
./render.sh -base-image <image> -version <version>
```

Where `base-image` is either ubuntu or python-slim and `version` is either main (latest) or one presented in original project's tags.

## How to stop
Run:
```shell
docker stop static-jinja-plus_container
```