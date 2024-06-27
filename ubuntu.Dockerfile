FROM ubuntu:24.04

ARG VERSION=main

RUN apt-get update && \
    apt-get install -y python3 python3-pip git && \
    rm -rf /var/lib/apt/lists/*

RUN git clone --branch ${VERSION} https://github.com/MrDave/StaticJinjaPlus.git /opt/StaticJinjaPlus

WORKDIR /opt/StaticJinjaPlus

RUN mv templates_example templates && \
    pip install -r requirements.txt

CMD ["python3", "main.py", "-w", "--srcpath", "/opt/StaticJinjaPlus/templates", "--outpath", "/opt/StaticJinjaPlus/build"]
