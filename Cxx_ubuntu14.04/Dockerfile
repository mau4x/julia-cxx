FROM ubuntu:14.04

MAINTAINER Ryuichi YAMAMOTO <zryuichi@gmail.com>

COPY Make.user /tmp/

ENV LLVM_VERSION 3.7.1
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
    gcc-4.8 \
    g++-4.8 \
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
    MARCH=x86-64 make -j2 && \
    rm -rf /julia/usr-staging && \
    mkdir -p /tmp/srccache && \
    mv /julia/deps/srccache/llvm-$LLVM_VERSION /tmp/srccache/ && \
    mv /julia/deps/Versions.make /tmp/ && \
    rm -rf /julia/deps && \
    mkdir -p /julia/deps/srccache && \
    mv /tmp/srccache/llvm-$LLVM_VERSION /julia/deps/srccache/ && \
    mv /tmp/Versions.make /julia/deps/

RUN /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/r9y9/Cxx.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.build("Cxx")'
