from gliacloud/base_images:caffe


# install bazel
run apt-get update
run apt-get install swig software-properties-common debconf-utils unzip -y 
run add-apt-repository ppa:webupd8team/java -y
run apt-get update
run echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
run apt-get install -y oracle-java8-installer

run wget https://github.com/bazelbuild/bazel/releases/download/0.2.2b/bazel-0.2.2b-installer-linux-x86_64.sh
run chmod +x bazel-0.2.2b-installer-linux-x86_64.sh

# bazel 0.2.2b
run ./bazel-0.2.2b-installer-linux-x86_64.sh --user
run rm bazel-0.2.2b-installer-linux-x86_64.sh

add bazelrc /root/.bazelrc
env PATH=$PATH:/root/bin


run pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.10.0rc0-cp27-none-linux_x86_64.whl

workdir /root
run git clone https://github.com/livingbio/syntaxnet_wrapper
run cd syntaxnet_wrapper && python setup.py install
run cd syntaxnet_wrapper/syntaxnet_wrapper && make
