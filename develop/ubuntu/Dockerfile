FROM ubuntu:24.04

ARG VERSION=main

ARG CHECKSUM=9adccb8fe17a40252df1a3acdea7edef4633b4ecaa8ba2dd5e0270f87ae43eab

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

ADD --checksum=sha256:${CHECKSUM} https://github.com/MrDave/StaticJinjaPlus/archive/refs/heads/${VERSION}.tar.gz /opt/StaticJinjaPlus.tar.gz

WORKDIR /opt

RUN tar -xzf /opt/StaticJinjaPlus.tar.gz && \
    mv /opt/StaticJinjaPlus-${VERSION} /opt/StaticJinjaPlus && \
    rm /opt/StaticJinjaPlus.tar.gz

WORKDIR /opt/StaticJinjaPlus

RUN mv templates_example templates && \
    pip install -r requirements.txt --break-system-packages

ENTRYPOINT ["python3", "main.py", "--srcpath", "/opt/StaticJinjaPlus/templates", "--outpath", "/opt/StaticJinjaPlus/build"]
