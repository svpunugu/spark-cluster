# Use openjdk:8-jre-slim as base image
FROM openjdk:8-jre-slim

# Install essential packages for building and installing Python
RUN apt-get update && \
    apt-get install -y \
    wget \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libgdbm-dev \
    libdb5.3-dev \
    libbz2-dev \
    libexpat1-dev \
    liblzma-dev \
    tk-dev \
    libffi-dev \
    git \
    ca-certificates

# Download Python 3.11.7 source
WORKDIR /tmp
RUN wget https://www.python.org/ftp/python/3.11.7/Python-3.11.7.tgz && \
    tar -xf Python-3.11.7.tgz && \
    rm Python-3.11.7.tgz

# Build and install Python 3.11.7
WORKDIR /tmp/Python-3.11.7
RUN ./configure --enable-optimizations && \
    make -j 4 && \
    make install && \
    rm -rf /tmp/Python-3.11.7

# Create aliases for python and python3
RUN ln -s /usr/local/bin/python3.11 /usr/local/bin/python 
# && \
#ln -s /usr/local/bin/python3.11 /usr/local/bin/python3

# Verify Python installation
RUN python --version && \
    python3 --version

# Cleanup
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a shared volume
ARG shared_workspace=/opt/workspace

RUN mkdir -p ${shared_workspace}


ENV SHARED_WORKSPACE=${shared_workspace}

# -- Runtime

VOLUME ${shared_workspace}
CMD ["bash"]