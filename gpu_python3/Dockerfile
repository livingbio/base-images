# docker build -f Dockerfile -t asia.gcr.io/living-bio/base_images:gpu_caffe_python3_7_1_cuda10_1 .
FROM nvidia/cuda:10.1-devel-ubuntu18.04

ENV PY3VER 3.7.1
ENV PY3VER_MAJ 3.7
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root

RUN apt update && \
    apt install -y wget curl git zsh build-essential libssl-dev libffi-dev libxml2-dev \
        libxslt1-dev libssl-dev libblas-dev liblapack-dev libatlas-base-dev gfortran libevent-dev \
        zlib1g-dev file swig libncursesw5-dev libreadline6-dev libgdbm-dev libc6-dev \
        libsqlite3-dev tk-dev sqlite3 python3-all-dev python3-dev libevent-dev libbz2-dev

RUN wget -q https://www.python.org/ftp/python/${PY3VER}/Python-${PY3VER}.tgz && \
    tar xfz Python-${PY3VER}.tgz && \
    cd Python-${PY3VER}/ && \
    ./configure --prefix /usr/local/lib/python${PY3VER} --enable-ipv6 --enable-shared --enable-loadable-sqlite-extensions --with-zlib && \
    make -j4 && \
    make install && \
    echo "/usr/local/lib/python${PY3VER}/lib" > /etc/ld.so.conf.d/python3.conf && \
    ldconfig && \
    ln -sf /usr/local/lib/python${PY3VER}/bin/python3 /usr/local/bin/python && \
    curl https://bootstrap.pypa.io/get-pip.py | python3 && \
    ln -sf /usr/local/lib/python${PY3VER}/bin/pip3 /usr/local/bin/pip && \
    pip install --upgrade pip && \
    pip install ipython jupyter numpy && \
    ln -sf /usr/local/lib/python${PY3VER}/bin/ipython3 /usr/local/bin/ipython && \
    cd / && rm -rf /root

ENV PATH /usr/local/lib/python${PY3VER}/bin/:${PATH}

WORKDIR /root

RUN wget https://storage.googleapis.com/gliacloud-package/img2vec_service/boost_1_72_0.tar.gz && \
    tar xvfz boost_1_72_0.tar.gz && \
    cd boost_1_72_0 && \
    export CPLUS_INCLUDE_PATH=/usr/local/lib/python${PY3VER}/include/python${PY3VER_MAJ}m && \
    ./bootstrap.sh --with-python=/usr/local/bin/python --with-python-root=/usr/local/lib/python${PY3VER} && \
    ./b2 stage threading=multi link=shared && \
    ./b2 install threading=multi link=shared && \
    cp stage/lib/libboost_python* /usr/local/lib/ && \
    cp stage/lib/libboost_numpy* /usr/local/lib && \
    ln -s /usr/local/lib/libboost_numpy37.so /usr/local/lib/libboost_numpy.so && \
    ln -s /usr/local/lib/libboost_python37.so /usr/local/lib/libboost_python.so && \
    cd / && rm -rf /root

WORKDIR /root

RUN apt -y install libprotobuf-dev libleveldb-dev libsnappy-dev libhdf5-serial-dev protobuf-compiler \
    libatlas-base-dev doxygen cmake libgflags-dev libgoogle-glog-dev liblmdb-dev libopencv-dev && \
    pip install scikit-image opencv-python protobuf && \
    cd / && rm -rf /root

WORKDIR /root

RUN wget https://storage.googleapis.com/gliacloud-package/img2vec_service/cmake-3.16.4-Linux-x86_64.tar.gz && \
    tar xvfz cmake-3.16.4-Linux-x86_64.tar.gz && \
    export PATH=/root/cmake-3.16.4-Linux-x86_64/bin:$PATH && \
    git clone https://github.com/NVIDIA/nccl.git && \
    cd nccl && \
    make -j8 install && \
    cd .. && \
    git clone https://github.com/livingbio/caffe && \
    mkdir -p caffe/build && \
    cd /root/caffe/build && \
    cmake -DPYTHON_EXECUTABLE=/usr/local/lib/python${PY3VER}/bin/python3 \
        -DPYTHON_INCLUDE_DIR=/usr/local/lib/python${PY3VER}/include/python${PY3VER_MAJ}m \
        -DPYTHON_LIBRARY=/usr/local/lib/python${PY3VER}/lib/libpython${PY3VER_MAJ}m.so \
        -DUSE_CUDNN=0 -DUSE_NCCL=1 -DCUDA_ARCH_NAME="Manual" -DCUDA_ARCH_BIN="60 61 70 75" -DCUDA_ARCH_PTX="60 61 70 75" .. && \
    make -j8 all && \
    make install && \
    cp install/lib/* /usr/local/lib/ && \
    make pycaffe && \
    cp -Lr ../python/caffe /usr/local/lib/python${PY3VER}/lib/python${PY3VER_MAJ}/site-packages/ && \
    cd / && rm -rf /root

WORKDIR /root
