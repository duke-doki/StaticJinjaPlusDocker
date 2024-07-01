FROM ubuntu:24.04

ARG VERSION=main

RUN apt-get update && \
    apt-get install -y python3 python3-pip git unzip && \
    rm -rf /var/lib/apt/lists/*

COPY StaticJinjaPlus-${VERSION}.zip /opt/StaticJinjaPlus.zip

WORKDIR /opt

RUN unzip StaticJinjaPlus.zip -d /opt && \
    mv /opt/StaticJinjaPlus-${VERSION} /opt/StaticJinjaPlus && \
    rm StaticJinjaPlus.zip

WORKDIR /opt/StaticJinjaPlus

RUN mv templates_example templates && \
    pip install -r requirements.txt --break-system-packages

CMD ["python3", "main.py", "-w", "--srcpath", "/opt/StaticJinjaPlus/templates", "--outpath", "/opt/StaticJinjaPlus/build"]
