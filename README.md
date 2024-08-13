# StaticJinjaPlusDocker

## Description

This repository provides Docker image based on the original project from [here](https://github.com/MrDave/StaticJinjaPlus).

Example of Docker Hub repository - [here](https://hub.docker.com/repository/docker/dukedoki/static-jinja-plus/general).

## Important Note

**<span style="color: red;">Do not attempt to manually build or run the Docker container.</span>** Use the `render.sh` script for all operations. Manual operations may not work as expected and could lead to issues.

## Prerequisites

1. **Install Docker**: Follow the installation guide [here](https://docs.docker.com/engine/install/).
2. **Docker Group (Optional)**: If you encounter permission issues, you may need to add your user to the Docker group:
    ```shell
    sudo usermod -aG docker <username>
    ```

## Using the `render.sh` Script

The `render.sh` script handles both building and running the Docker container. It automatically takes care of the correct version, base image, and optional arguments.

### Script Usage

1. **Prepare the `templates` Directory**

   Ensure you have a `templates` directory in your current working directory. If it is missing, default templates will be used.

2. **Run the Script**

   Execute the `render.sh` script with the desired options:

   ```shell
   ./render.sh -base-image <image> -version <version> [-w]
   ```
   - `-base-image` can be either `ubuntu` or `python-slim`.
   - `-version` can be `main` (latest) or any specific version from the project's tags.
   - `-w` is an optional flag. Include it if you want to pass `-w` to the `python3` command inside the container.

### Example

To build and run the container using the python-slim base image and version 0.1.0, including the -w flag:

```shell
./render.sh -base-image python-slim -version 0.1.0 -w
```

## Stopping the Container

If you need to stop the running container, use the following command:

```shell
docker stop <container>
```

To remove the container and its associated image, use:

```shell
docker rm <container>
docker rmi <image>:<tag>
```


## Uploading Images to Docker Hub

If you need to upload images to Docker Hub, follow these steps:

Find Your Images' IDs:

```shell
docker images
```

Tag the Images:

```shell
docker tag <image_id> <username>/static-jinja-plus:<tag>
```

Push the Images to Docker Hub:

```shell
docker push <username>/static-jinja-plus:<tag>
```

### Example

```shell
duke_duke@Duke-Duke:~$ docker images
REPOSITORY                    TAG             IMAGE ID       CREATED          SIZE
static-jinja-plus             0.1.0-python    7bb03fbb27f8   7 minutes ago    145MB
duke_duke@Duke-Duke:~$ docker tag 7bb03fbb27f8 dukedoki/static-jinja-plus:0.1.0-python
duke_duke@Duke-Duke:~$ docker push dukedoki/static-jinja-plus:0.1.0-python
```

## Notes

- Ensure you are logged in to Docker Hub before pushing images. Use `docker login` to authenticate.