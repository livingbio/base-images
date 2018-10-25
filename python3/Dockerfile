FROM asia.gcr.io/living-bio/base_images:tomcat

ENV PY3VER 3.6.7
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root

RUN apt-get update && \
    apt-get install build-essential libssl-dev libffi-dev -y && \
    apt-get install git libxml2-dev libxslt1-dev python-dev libssl-dev -y && \
    apt-get install libblas-dev liblapack-dev libatlas-base-dev gfortran zsh libevent-dev -y && \
    apt-get install zlib1g-dev file swig libncursesw5-dev libreadline6-dev -y && \
    apt-get install libgdbm-dev libc6-dev libsqlite3-dev tk-dev sqlite3 -y && \
    apt-get install python-all-dev libevent-dev libbz2-dev -y

RUN wget -q https://www.python.org/ftp/python/${PY3VER}/Python-${PY3VER}.tgz && \
    tar xfz Python-${PY3VER}.tgz && \
    cd Python-${PY3VER}/ && \
    ./configure --prefix /usr/local/lib/python${PY3VER} --enable-ipv6 --enable-shared --enable-loadable-sqlite-extensions --with-zlib && \
    make -j20 && \
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

CMD ipython
