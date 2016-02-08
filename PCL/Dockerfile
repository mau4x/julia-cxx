FROM r9y9/julia-cxx:latest

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
    libopenni-dev \
    libopenni2-dev \
    libvtk6-dev \
    libvtk6.2

RUN /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/r9y9/PCL.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.build("PCL")'
