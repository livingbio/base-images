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

# install bazel
run apt-get update
run apt-get install swig software-properties-common debconf-utils unzip -y 
run add-apt-repository ppa:webupd8team/java -y
run apt-get update
run echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
run apt-get install -y oracle-java8-installer

run wget https://github.com/bazelbuild/bazel/releases/download/0.2.2b/bazel-0.2.2b-installer-linux-x86_64.sh
run chmod +x bazel-0.2.2b-installer-linux-x86_64.sh

run ./bazel-0.2.2b-installer-linux-x86_64.sh --user
run rm bazel-0.2.2b-installer-linux-x86_64.sh

add bazelrc /root/.bazelrc
env PATH=$PATH:/root/bin

# install python package
run apt-get update
run apt-get install -y python-pip python-psycopg2

run pip install -r /src/requirements.txt


run pip install -r /src/requirements.txt
run locale-gen zh_TW zh_TW.UTF-8 zh_CN.UTF-8 en_US.UTF-8
run apt-get update && apt-get install -y python-opencv
run python -m nltk.downloader punkt

run pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0rc0-cp27-none-linux_x86_64.whl

workdir /root
run git clone https://github.com/livingbio/syntaxnet_wrapper
run cd syntaxnet_wrapper && python setup.py
run cd syntaxnet_wrapper/syntaxnet_wrapper && make
