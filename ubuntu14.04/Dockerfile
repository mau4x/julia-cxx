FROM ubuntu:14.04

MAINTAINER Ryuichi YAMAMOTO <zryuichi@gmail.com>

COPY Make.user /tmp/
COPY jitlayers.patch /tmp/

ENV LLVM_VERSION 3.8.1
ENV JULIA_VERSION d0e7684dd0ce867e1add2b88bb91f1c4574100e0
ENV CXX_VERSION 3f99d56476054241d3c00f331d6377284773367f
ENV PATH /julia/usr/bin:$PATH

RUN apt-get update && \
    apt-get install -y software-properties-common python-software-properties && \
    add-apt-repository -y ppa:ubuntu-toolchain-r/test && \
    apt-get update && \
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
    gcc-6 \
    g++-6 \
    gfortran \
    libblas-dev \
    liblapack-dev \
    libgmp-dev \
    libmpfr-dev \
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
    patch -p0 < /tmp/jitlayers.patch && \
    cp /tmp/Make.user Make.user && \
    cat Make.user && \
    MARCH=x86-64 make USE_SYSTEM_ARPACK=1 USE_SYSTEM_BLAS=1 USE_SYSTEM_LAPACK=1 \
    USE_SYSTEM_GMP=1 USE_SYSTEM_MPFR=1 -j2 && \
    rm -rf /julia/usr-staging && \
    mkdir -p /tmp/srccache && \
    mv /julia/deps/srccache/llvm-$LLVM_VERSION /tmp/srccache/ && \
    mv /julia/deps/Versions.make /tmp/ && \
    rm -rf /julia/deps && \
    mkdir -p /julia/deps/srccache && \
    mv /tmp/srccache/llvm-$LLVM_VERSION /julia/deps/srccache/ && \
    mv /tmp/Versions.make /julia/deps/

RUN /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/r9y9/Cxx.jl")' && \
    cd `/julia/usr/bin/julia -e 'print(Pkg.dir("Cxx"))'` && \
    git checkout $CXX_VERSION && \
    /julia/usr/bin/julia -e 'Pkg.build("Cxx")'
