#!/bin/bash

VERSION="main"
BASE_IMAGE="ubuntu"

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -version) VERSION="$2"; shift ;;
        -base-image) BASE_IMAGE="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if [ "$BASE_IMAGE" == "ubuntu" ]; then
    DOCKERFILE="ubuntu.Dockerfile"
elif [ "$BASE_IMAGE" == "python-slim" ]; then
    DOCKERFILE="python-slim.Dockerfile"
else
    echo "Unsupported base image: $BASE_IMAGE"
    exit 1
fi

if [ "$VERSION" == "main" ]; then
    TAG="latest-${BASE_IMAGE}"
else
    TAG="${VERSION}-${BASE_IMAGE}"
fi

docker build --build-arg VERSION="${VERSION}" -t "static-jinja-plus:${TAG}" -f "${DOCKERFILE}" .

docker rm -f static-jinja-plus_container_temp

docker run -d --name static-jinja-plus_container_temp \
    "static-jinja-plus:${TAG}"

if [ ! -d "$(pwd)/templates" ] || [ -z "$(ls -A "$(pwd)/templates")" ]; then
    docker cp static-jinja-plus_container_temp:/opt/StaticJinjaPlus/templates "$(pwd)/templates"
fi

if [ ! -d "$(pwd)/build" ] || [ -z "$(ls -A "$(pwd)/build")" ]; then
    docker cp static-jinja-plus_container_temp:/opt/StaticJinjaPlus/build "$(pwd)/build"
fi

docker rm -f static-jinja-plus_container_temp

docker run -d --name static-jinja-plus_container \
    -v "$(pwd)/templates:/opt/StaticJinjaPlus/templates" \
    -v "$(pwd)/build:/opt/StaticJinjaPlus/build" \
    "static-jinja-plus:${TAG}"
