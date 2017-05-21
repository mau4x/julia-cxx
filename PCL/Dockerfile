FROM r9y9/julia-cxx:ubuntu16.04

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
    libproj-dev \
    libvtk6-dev && \
    apt-get clean

ENV BOOST_INCLUDE_DIR /usr/include
ENV EIGEN_INCLUDE_DIR /usr/include/eigen3
ENV FLANN_INCLUDE_DIR /usr/include
ENV VTK_INCLUDE_DIR_PARENT /usr/include
ENV CC gcc-6
ENV CXX g++-6
ENV PCLJL_RUN_VISUALIZATION_TESTS 0

RUN /julia/usr/bin/julia -e 'Pkg.add("BinDeps");Pkg.add("DocStringExtensions")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/LibPCL.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLCommon.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLFeatures.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLFilters.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLIO.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLKDTree.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLKeyPoints.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLOctree.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLRecognition.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLRegistration.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLSampleConsensus.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLSearch.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLSegmentation.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLSurface.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLTracking.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCLVisualization.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.clone("https://github.com/JuliaPCL/PCL.jl")' && \
    /julia/usr/bin/julia -e 'Pkg.build("LibPCL")' && \
    /julia/usr/bin/julia -e 'Pkg.test("PCL")'
