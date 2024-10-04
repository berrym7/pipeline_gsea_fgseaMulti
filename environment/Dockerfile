# hash:sha256:2c1dee0f6f07479f47d30cdd4abb3ad772290a0f5ee2f0c8db9599cecefe14fb
ARG REGISTRY_HOST
FROM $REGISTRY_HOST/codeocean/pytorch:2.1.0-cuda11.8.0-mambaforge23.1.0-4-python3.10.12-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

ARG GIT_ASKPASS
ARG GIT_ACCESS_TOKEN
COPY git-askpass /

RUN pip install -U --no-cache-dir \
    click \
    gseapy \
    pandas
