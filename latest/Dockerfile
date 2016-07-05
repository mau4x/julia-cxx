FROM ubuntu:16.04

MAINTAINER Ryuichi YAMAMOTO <zryuichi@gmail.com>

COPY Make.user /tmp/

ENV LLVM_VERSION 3.7.1
ENV JULIA_VERSION 7a65d001b952e57a4907c071a5590080c7065ac2
ENV CXX_VERSION 7ec3373bdd26213bca7ee540bac79b4a04094f76
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
    MARCH=x86-64 make -j2 && \
    rm -rf /julia/usr-staging && \
    mkdir -p /tmp/srccache && \
    mv /julia/deps/srccache/llvm-$LLVM_VERSION /tmp/srccache/ && \
    mv /julia/deps/Versions.make /tmp/ && \
    rm -rf /julia/deps && \
    mkdir -p /julia/deps/srccache && \
    mv /tmp/srccache/llvm-$LLVM_VERSION /julia/deps/srccache/ && \
    mv /tmp/Versions.make /julia/deps/

RUN /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/Keno/Cxx.jl")' && \
    cd `/julia/usr/bin/julia -e 'print(Pkg.dir("Cxx"))'` && \
    git checkout $CXX_VERSION && \
    /julia/usr/bin/julia -e 'Pkg.build("Cxx")'
