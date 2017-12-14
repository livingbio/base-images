FROM asia.gcr.io/living-bio/base_images:tomcat

ENV PY2VER 2.7.13
ENV PY3VER 3.6.2

WORKDIR /root

RUN add-apt-repository ppa:git-core/ppa -y && \
    apt-get update && \
    apt-get install git -y && \
    apt-get install libxml2-dev libxslt1-dev python-dev libssl-dev -y && \
    apt-get install libblas-dev liblapack-dev libatlas-base-dev gfortran zsh libevent-dev -y && \
    apt-get install zlib1g-dev file swig python2.7 libncursesw5-dev libreadline6-dev -y && \
    apt-get install libgdbm-dev libc6-dev libsqlite3-dev tk-dev sqlite3 -y && \
    apt-get install python-all-dev libevent-dev libbz2-dev -y

RUN wget -q https://www.python.org/ftp/python/${PY2VER}/Python-${PY2VER}.tgz && \
    tar xfz Python-${PY2VER}.tgz && \
    cd Python-${PY2VER}/ && \
    ./configure --prefix /usr/local/lib/python${PY2VER} --enable-ipv6 --enable-shared --enable-unicode=ucs4 --enable-loadable-sqlite-extensions --with-zlib && \
    make -j20 && \
    make install && \
    echo "/usr/local/lib/python${PY2VER}/lib" > /etc/ld.so.conf.d/python2.conf && \
    ldconfig && \
    ln -sf /usr/local/lib/python${PY2VER}/bin/python /usr/local/bin/python && \
    ln -sf /usr/local/lib/python${PY2VER}/bin/python /usr/local/bin/python2 && \
    curl https://bootstrap.pypa.io/get-pip.py | python && \
    ln -sf /usr/local/lib/python${PY2VER}/bin/pip /usr/local/bin/pip && \
    ln -sf /usr/local/lib/python${PY2VER}/bin/ipython /usr/local/bin/ipython && \
    rm -rf /root/*

RUN wget -q https://www.python.org/ftp/python/${PY3VER}/Python-${PY3VER}.tgz && \
    tar xfz Python-${PY3VER}.tgz && \
    cd Python-${PY3VER}/ && \
    ./configure --prefix /usr/local/lib/python${PY3VER} --enable-ipv6 --enable-shared --enable-loadable-sqlite-extensions --with-zlib && \
    make -j20 && \
    make install && \
    echo "/usr/local/lib/python${PY3VER}/lib" > /etc/ld.so.conf.d/python3.conf && \
    ldconfig && \
    ln -sf /usr/local/lib/python${PY3VER}/bin/python3 /usr/local/bin/python3 && \
    curl https://bootstrap.pypa.io/get-pip.py | python3 && \
    ln -sf /usr/local/lib/python${PY3VER}/bin/pip3 /usr/local/bin/pip3 && \
    ln -sf /usr/local/lib/python${PY3VER}/bin/ipython3 /usr/local/bin/ipython3 && \
    rm -rf /root/*

RUN pip install jupyter numpy && \
    pip3 install jupyter numpy

CMD ipython
