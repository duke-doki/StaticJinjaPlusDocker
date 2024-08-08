FROM python:3.12-slim

ARG VERSION=0.1.0

ARG CHECKSUM=3555bcfd670e134e8360ad934cb5bad1bbe2a7dad24ba7cafa0a3bb8b23c6444

ADD --checksum=sha256:${CHECKSUM} https://github.com/MrDave/StaticJinjaPlus/archive/refs/tags/${VERSION}.tar.gz /opt/StaticJinjaPlus.tar.gz

WORKDIR /opt

RUN tar -xzf StaticJinjaPlus.tar.gz && \
    mv /opt/StaticJinjaPlus-${VERSION} /opt/StaticJinjaPlus && \
    rm StaticJinjaPlus.tar.gz

WORKDIR /opt/StaticJinjaPlus

RUN mv templates_example templates && \
    pip install -r requirements.txt

CMD ["python3", "main.py", "-w", "--srcpath", "/opt/StaticJinjaPlus/templates", "--outpath", "/opt/StaticJinjaPlus/build"]
