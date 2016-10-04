from nvidia/cuda:7.5-devel
add . /src
run apt-key add /src/nvidia.pgp.key
# install caffe
RUN apt-get update && apt-get install -y \
  git \
  wget \
  bc \
  cmake \
  libatlas-base-dev \
  libatlas-dev \
  libboost-all-dev \
  libopencv-dev \
  libprotobuf-dev \
  libgoogle-glog-dev \
  libgflags-dev \
  protobuf-compiler \
  libhdf5-dev \
  libleveldb-dev \
  liblmdb-dev \
  libsnappy-dev \
  python-dev \
  python-pip \
  python-numpy \
  gfortran > /dev/null

RUN cd /root && git clone https://github.com/BVLC/caffe.git && cd caffe && \
  cat python/requirements.txt | xargs -n1 pip install

# Move into Caffe repo
RUN cd /root/caffe && \
  mkdir build && cd build && \
  cmake .. && \
  make -j"$(nproc)" all && \
  make install

ENV PYTHONPATH=/root/caffe/python:$PYTHONPATH

RUN ln -s /dev/null /dev/raw1394

env LC_CTYPE zh_TW.UTF-8
env LC_MESSAGES zh_TW.UTF-8
env LC_TIME zh_TW.UTF-8

# install python package
run apt-get update
run apt-get install -y python-pip python-psycopg2

run pip install -r /src/requirements.txt


run pip install -r /src/requirements.txt
run locale-gen zh_TW zh_TW.UTF-8 zh_CN.UTF-8 en_US.UTF-8
run apt-get update && apt-get install -y python-opencv
run python -m nltk.downloader punkt
