# docker build -f 1_zh.dockerfile -t asia.gcr.io/living-bio/base_images:python3_7_1_zh .
FROM asia.gcr.io/living-bio/base_images:python3_7_1

ENV TOMCAT_VERSION 8.5.35

# Set locales
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_GB.UTF-8
ENV LANG en_GB.UTF-8
ENV LC_CTYPE en_GB.UTF-8

# Fix sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install dependencies
RUN apt-get update && \
apt-get install -y git build-essential curl wget unzip tar software-properties-common

# Install JDK 8
RUN \
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
add-apt-repository -y ppa:webupd8team/java && \
apt-get update && \
apt-get install -y oracle-java8-installer && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Get Tomcat
RUN wget --quiet --no-cookies http://ftp.twaren.net/Unix/Web/apache/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tgz && \
tar xzvf /tmp/tomcat.tgz -C /opt && \
mv /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat && \
rm /tmp/tomcat.tgz && \
rm -rf /opt/tomcat/webapps/*

ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin

EXPOSE 8080

RUN git clone https://github.com/livingbio/StanfordNlpServer && \
    mkdir /opt/tomcat/webapps/ROOT && \
    cp /root/StanfordNlpServer/tomcat-users.xml /opt/tomcat/conf/tomcat-users.xml && \
    cp /root/StanfordNlpServer/index.html /opt/tomcat/webapps/ROOT/index.html && \
    cp /root/StanfordNlpServer/run.sh /root && \
    cp -r /root/StanfordNlpServer /opt/tomcat/webapps/nlp && \
    cd /opt/tomcat/webapps/nlp && \
    make build

ENV STANFORD_NLP localhost:8080/nlp
ENV PIP_EXTRA_INDEX_URL https://gliacloud:cookiebank@pypi-dot-living-bio.appspot.com/pypi

RUN pip install zhconvert
