from ubuntu:16.04

# java 8
run apt-get update
run apt-get install swig software-properties-common debconf-utils unzip curl apt-transport-https -y
run add-apt-repository ppa:webupd8team/java -y
run apt-get update
run echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
run apt-get install -y oracle-java8-installer

# jenkins
#run wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | apt-key add -
#run sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
#run apt-get update
#run apt-get install jenkins -y

# slave
ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins

ARG VERSION=2.62

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar



run apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
run apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
run apt-get update
run apt-get install docker-engine -y


run apt-get install python-pip -y
run pip install -U pip virtualenv scipy==0.18.0 numpy==1.11.1 scikit-learn==0.18

run add-apt-repository ppa:jonathonf/ffmpeg-3 -y
run apt-get update
run apt-get install ffmpeg imagemagick -y

# jnlp
# USER jenkins
RUN mkdir /home/jenkins/.jenkins
VOLUME /home/jenkins/.jenkins
WORKDIR /home/jenkins

run apt-get install sudo
RUN echo "jenkins:jenkins" | chpasswd
RUN echo "jenkins   ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/jenkins
RUN sed -ri 's/Defaults    requiretty/#Defaults    requiretty/g' /etc/sudoers

COPY jenkins-slave /usr/local/bin/jenkins-slave
ENTRYPOINT ["jenkins-slave"]

