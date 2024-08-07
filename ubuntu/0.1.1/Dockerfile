FROM ubuntu:24.04

ARG VERSION=0.1.1

ARG CHECKSUM=30d9424df1eddb73912b0e2ad5375fa2c876c8e30906bec91952dfb75dcf220b

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

ADD --checksum=sha256:${CHECKSUM} https://github.com/MrDave/StaticJinjaPlus/archive/refs/tags/${VERSION}.tar.gz /opt/StaticJinjaPlus.tar.gz

WORKDIR /opt

RUN tar -xzf /opt/StaticJinjaPlus.tar.gz && \
    mv /opt/StaticJinjaPlus-${VERSION} /opt/StaticJinjaPlus && \
    rm /opt/StaticJinjaPlus.tar.gz

WORKDIR /opt/StaticJinjaPlus

RUN mv templates_example templates && \
    pip install -r requirements.txt --break-system-packages

CMD ["python3", "main.py", "-w", "--srcpath", "/opt/StaticJinjaPlus/templates", "--outpath", "/opt/StaticJinjaPlus/build"]
