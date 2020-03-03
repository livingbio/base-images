# https://github.com/pytorch/pytorch/blob/master/docker/pytorch/Dockerfile
# docker build -f Dockerfile -t asia.gcr.io/living-bio/base_images:pytorch_py37_cuda10_cudnn7 .
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
ARG PYTHON_VERSION=3.7
RUN apt update && apt install -y --no-install-recommends \
         software-properties-common \
         build-essential \
         cmake \
         git \
         curl \
         vim \
         ca-certificates \
         libjpeg-dev \
         libpng-dev &&\
     rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y ppa:jonathonf/ffmpeg-4 && \
    apt update && apt install -y ffmpeg

RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include ninja cython typing && \
     /opt/conda/bin/conda install -y -c pytorch magma-cuda100 && \
     /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/bin:$PATH
# This must be done before pip so that requirements.txt is available
WORKDIR /opt

RUN TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0 7.5+PTX" TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
    CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" \
    git clone https://github.com/pytorch/pytorch && \
    cd pytorch && \
    git submodule update --init --recursive && \
    pip install -v . && \
    cd .. && \
    rm -rf /opt/pytorch

RUN git clone https://github.com/pytorch/vision.git && \
    cd vision && \
    pip install -v . && \
    cd .. && \
    rm -rf /opt/vision

RUN git clone https://github.com/nvidia/apex && \
    cd apex && \
    python setup.py install --cuda_ext --cpp_ext && \
    cd .. && \
    rm -rf /opt/apex

WORKDIR /workspace
RUN chmod -R a+w /workspace
