#!/bin/bash

VERSION="main"
BASE_IMAGE="ubuntu"
CHECKSUM="9adccb8fe17a40252df1a3acdea7edef4633b4ecaa8ba2dd5e0270f87ae43eab"
INCLUDE_W_FLAG="false"


while [[ "$#" -gt 0 ]]; do
    case $1 in
        -version) VERSION="$2"; shift ;;
        -base-image) BASE_IMAGE="$2"; shift ;;
        -w) INCLUDE_W_FLAG="true" ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done


if [ "$VERSION" == "main" ]; then
    CHECKSUM="9adccb8fe17a40252df1a3acdea7edef4633b4ecaa8ba2dd5e0270f87ae43eab"
    TAG="latest-${BASE_IMAGE}"
    DIR1="develop"
elif [ "$VERSION" == "0.1.1" ]; then
    CHECKSUM="30d9424df1eddb73912b0e2ad5375fa2c876c8e30906bec91952dfb75dcf220b"
    TAG="${VERSION}-${BASE_IMAGE}"
    DIR1="0.1"
elif [ "$VERSION" == "0.1.0" ]; then
    CHECKSUM="3555bcfd670e134e8360ad934cb5bad1bbe2a7dad24ba7cafa0a3bb8b23c6444"
    TAG="${VERSION}-${BASE_IMAGE}"
    DIR1="0.1"
fi


if [ "$BASE_IMAGE" == "ubuntu" ]; then
    DIR2="ubuntu"
elif [ "$BASE_IMAGE" == "python" ]; then
    DIR2="python"
else
    echo "Unsupported base image: $BASE_IMAGE"
    exit 1
fi


docker build --build-arg VERSION="${VERSION}" --build-arg CHECKSUM="${CHECKSUM}" -t "static-jinja-plus:${TAG}" -f "${DIR1}/${DIR2}/Dockerfile" .


docker run -d --name static-jinja-plus_container_temp \
    "static-jinja-plus:${TAG}"


if [ ! -d "$(pwd)/templates" ] || [ -z "$(ls -A "$(pwd)/templates")" ]; then
    docker cp static-jinja-plus_container_temp:/opt/StaticJinjaPlus/templates "$(pwd)/templates"
fi

if [ ! -d "$(pwd)/build" ] || [ -z "$(ls -A "$(pwd)/build")" ]; then
    docker cp static-jinja-plus_container_temp:/opt/StaticJinjaPlus/build "$(pwd)/build"
fi


docker rm -f static-jinja-plus_container_temp


if [ "$INCLUDE_W_FLAG" == "true" ]; then
    docker run -d --name static-jinja-plus_container \
        -v "$(pwd)/templates:/opt/StaticJinjaPlus/templates" \
        -v "$(pwd)/build:/opt/StaticJinjaPlus/build" \
        "static-jinja-plus:${TAG}" -w
else
    docker run -d --name static-jinja-plus_container \
        -v "$(pwd)/templates:/opt/StaticJinjaPlus/templates" \
        -v "$(pwd)/build:/opt/StaticJinjaPlus/build" \
        "static-jinja-plus:${TAG}"
fi
