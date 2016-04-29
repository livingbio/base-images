FROM ubuntu:14.04
MAINTAINER gliacloud <robot@gliacloud.com>

RUN apt-get update
RUN apt-get install -y python-pip python-dev libxml2-dev libxslt1-dev python-lxml libpq-dev curl git unzip
RUN apt-get install -y libjpeg-dev libpng-dev libffi-dev

ADD requirements.txt /tmp/requirement.txt
RUN pip install -r /tmp/requirement.txt

RUN locale-gen zh_TW.UTF-8

# default running endpoint
RUN curl https://raw.githubusercontent.com/gliacloud/deploy/new/src/run.sh -o /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh
RUN mkdir /logs
