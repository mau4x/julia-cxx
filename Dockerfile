FROM ubuntu:16.04

MAINTAINER Ryuichi YAMAMOTO

COPY Make.user /tmp/

ENV JULIA_VERSION dbdf28cfe80213271a0ed612a9812627a76de32b
ENV PATH /julia/usr/bin:$PATH

RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confdef" -o DPkg::Options::="--force-confold" && \
    apt-get install -y \
    man-db \
    less \
    git \
    perl \
    m4 \
    unzip \
    bzip2 \
    cmake \
    wget \
    curl \
    pkg-config \
    build-essential \
    clang \
    gcc-5 \
    g++-5 \
    gfortran \
    libssl-dev \
    libc6 \
    libc6-dev \
    libedit-dev \
    libncurses5-dev \
    python \
    python-dev && \
    apt-get clean

RUN git clone https://github.com/JuliaLang/julia.git /julia && \
    cd /julia && \
    git checkout $JULIA_VERSION && \
    cp /tmp/Make.user Make.user && \
    cat Make.user && \
    make -j4 && \
    rm -rf /julia/usr-staging && \
    mkdir -p /tmp/llvm && \
    mv /julia/deps/srccache/llvm-3.7.1/include /tmp/llvm/ && \
    rm -rf /julia/deps && \
    mkdir -p /julia/deps/srccache/llvm-3.7.1 && \
    mv /tmp/llvm/include /julia/deps/srccache/llvm-3.7.1/

RUN /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/r9y9/Cxx.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.build("Cxx")'
