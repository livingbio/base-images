# docker build -f Dockerfile -t asia.gcr.io/living-bio/base_images:python3_7_1 .
FROM ubuntu:16.04

ENV PY3VER 3.7.1
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root

RUN apt-get update && \
    apt-get install -y wget curl git zsh build-essential libssl-dev libffi-dev libxml2-dev \
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
    rm -rf /root/*

ENV PATH="/usr/local/lib/python${PY3VER}/bin/:${PATH}"

CMD ipython
