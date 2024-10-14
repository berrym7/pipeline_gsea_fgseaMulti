# hash:sha256:1e40c0c06b7d9f807de10b99c723e6e990023e28128cebc49394574461d54d94
ARG REGISTRY_HOST
FROM $REGISTRY_HOST/codeocean/py-r:python3.10.12-R4.2.3-IRkernel-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

ARG GIT_ASKPASS
ARG GIT_ACCESS_TOKEN
COPY git-askpass /

RUN pip install -U --no-cache-dir \
    click==8.1.7 \
    gseapy==1.1.3 \
    pandas==2.2.3

ARG RCACHE_OPTIONS
RUN echo $RCACHE_OPTIONS >> $(Rscript -e 'cat(R.home())')/etc/Rprofile.site
RUN Rscript -e 'remotes::install_version("data.table", "1.16.2")' \
    && Rscript -e 'remotes::install_version("optparse", "1.7.5")'

RUN Rscript -e 'options(warn=2); install.packages("BiocManager")'
RUN Rscript -e 'options(warn=2); BiocManager::install(c( \
        "fgsea" \
    ))' # Original versions: 1.24.0
