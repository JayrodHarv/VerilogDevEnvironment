FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Base tools
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    wget \
    ca-certificates \
    gtkwave \
    iverilog \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# ---- Install Verible (formatter + language server) ----
RUN set -eux; \
    VERIBLE_URL=$(wget -qO- https://api.github.com/repos/chipsalliance/verible/releases/latest \
    | grep browser_download_url \
    | grep linux-static-x86_64 \
    | cut -d '"' -f 4); \
    wget "$VERIBLE_URL" -O verible.tar.gz; \
    tar -xzf verible.tar.gz; \
    cp verible-*/bin/* /usr/local/bin/; \
    rm -rf verible*

# ---- Create vscode user ----
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /workspace