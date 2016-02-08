FROM r9y9/julia-cxx:ubuntu14.04

MAINTAINER Ryuichi YAMAMOTO <zryuichi@gmail.com>

RUN apt-get update && \
    apt-get install -y \
    mpi-default-dev \
    openmpi-bin \
    openmpi-common \
    libflann-dev \
    libeigen3-dev \
    libboost-all-dev \
    libqhull-dev \
    libusb-dev \
    libusb-1.0-0-dev \
    freeglut3-dev \
    libxmu-dev \
    libxi-dev \
    libvtk6-dev \
    libvtk6 && \
    apt-get clean

ENV BOOST_INCLUDE_DIR /usr/include
ENV EIGEN_INCLUDE_DIR /usr/include/eigen3
ENV FLANN_INCLUDE_DIR /usr/include
ENV VTK_INCLUDE_DIR_PARENT /usr/include

RUN /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/r9y9/PCL.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.build("PCL")'
