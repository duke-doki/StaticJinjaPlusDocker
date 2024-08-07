FROM python:3.12-slim

ARG VERSION=0.1.1

ARG CHECKSUM=30d9424df1eddb73912b0e2ad5375fa2c876c8e30906bec91952dfb75dcf220b

ADD --checksum=sha256:${CHECKSUM} https://github.com/MrDave/StaticJinjaPlus/archive/refs/tags/${VERSION}.tar.gz /opt/StaticJinjaPlus.tar.gz

WORKDIR /opt

RUN tar -xzf StaticJinjaPlus.tar.gz && \
    mv /opt/StaticJinjaPlus-${VERSION} /opt/StaticJinjaPlus && \
    rm StaticJinjaPlus.tar.gz

WORKDIR /opt/StaticJinjaPlus

RUN mv templates_example templates && \
    pip install -r requirements.txt

CMD ["python3", "main.py", "-w", "--srcpath", "/opt/StaticJinjaPlus/templates", "--outpath", "/opt/StaticJinjaPlus/build"]
