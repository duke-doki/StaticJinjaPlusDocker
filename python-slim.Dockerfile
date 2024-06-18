FROM python:slim

ARG VERSION=main

RUN apt-get update && \
    apt-get install -y git

WORKDIR /opt

RUN git clone --branch ${VERSION} https://github.com/MrDave/StaticJinjaPlus.git

WORKDIR /opt/StaticJinjaPlus

RUN mv templates_example templates

RUN python3 -m venv venv

RUN venv/bin/pip install -r requirements.txt

CMD ["/bin/bash", "-c", ". venv/bin/activate && python3 main.py -w --srcpath /opt/StaticJinjaPlus/templates --outpath /opt/StaticJinjaPlus/build"]
