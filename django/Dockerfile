FROM ubuntu:16.04
MAINTAINER gliacloud <robot@gliacloud.com>


RUN apt-get update
RUN apt-get install -y libssl-dev \
                       openssl \
                       imagemagick \
                       ffmpeg \
                       libfreeimage-dev \
                       libjpeg-dev \
                       libpng-dev \
                       libffi-dev \
                       libblas-dev \
                       liblapack-dev \
                       libatlas-base-dev \
                       gfortran \
                       python-pip \
                       wget \
                       libevent-dev \
                       python-pip \
                       python-dev \
                       libxml2-dev \
                       libxslt1-dev \
                       python-lxml \
                       libpq-dev \
                       curl \
                       git \
                       unzip \
                       python-numpy \
                       python-sklearn \
                       python-skimage \
                       python-gevent \
                       python-libsass

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install -U pip
ADD requirements.txt /tmp/requirement.txt
RUN pip install -r /tmp/requirement.txt

RUN locale-gen zh_TW.UTF-8

# default running endpoint
RUN curl https://raw.githubusercontent.com/gliacloud/deploy/new/src/run.sh -o /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh
RUN mkdir /logs

RUN locale-gen zh_TW.UTF-8  
ENV LANG zh_TW.UTF-8  
ENV LANGUAGE zh_TW:en  
ENV LC_ALL zh_TW.UTF-8  

