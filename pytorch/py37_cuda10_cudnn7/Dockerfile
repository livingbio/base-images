# https://github.com/pytorch/pytorch/blob/master/Dockerfile
# docker build -f Dockerfile -t asia.gcr.io/living-bio/base_images:pytorch_py37_cuda10_cudnn7 .
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
ARG PYTHON_VERSION=3.7
RUN apt update && apt install -y --no-install-recommends \
         software-properties-common \
         build-essential \
         cmake \
         ccache \
         git \
         curl \
         vim \
         ca-certificates \
         libjpeg-dev \
         libpng-dev &&\
     rm -rf /var/lib/apt/lists/*

RUN /usr/sbin/update-ccache-symlinks
RUN mkdir /opt/ccache && ccache --set-config=cache_dir=/opt/ccache

RUN add-apt-repository -y ppa:jonathonf/ffmpeg-4 && \
    apt update && apt install -y ffmpeg

RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install -y python=$PYTHON_VERSION numpy pyyaml scipy ipython mkl mkl-include ninja cython && \
     /opt/conda/bin/conda install -y pip setuptools && \
     /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/bin:$PATH
# This must be done before pip so that requirements.txt is available
WORKDIR /opt

RUN curl https://storage.googleapis.com/gliacloud-package/img2vec_service/cmake-3.16.4-Linux-x86_64.tar.gz --output cmake.tar.gz && \
    tar xfz cmake.tar.gz && \
    rm -f cmake.tar.gz

ENV PATH /opt/cmake-3.16.4-Linux-x86_64/bin:$PATH

RUN export TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0 7.5 6.0+PTX 6.1+PTX 7.0+PTX 7.5+PTX" \
        TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
        CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" && \
    git clone https://github.com/pytorch/pytorch && \
    cd pytorch && \
    git submodule update --init --recursive && \
    pip install -v . && \
    cd .. && \
    rm -rf /opt/pytorch /opt/ccache/*

RUN apt install -y libavcodec-dev libavformat-dev libavutil-dev libswresample-dev libswscale-dev

RUN git clone https://github.com/pytorch/vision.git && \
    cd vision && \
    pip install -v . && \
    cd .. && \
    rm -rf /opt/vision /opt/ccache/*

RUN git clone https://github.com/NVIDIA/apex.git && \
    cd apex && \
    pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" . && \
    cd .. && \
    rm -rf /opt/apex /opt/ccache/*

WORKDIR /workspace
RUN chmod -R a+w /workspace
