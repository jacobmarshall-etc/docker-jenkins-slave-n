FROM node:slim
MAINTAINER Jacob Marshall <jacob@manage.net.nz>

ENV JENKINS_USERNAME jenkins
ENV JENKINS_PASSWORD jenkins

RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y git openssh-server && \
    apt-get -t jessie-backports install -y openjdk-8-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd && \
    useradd -m -s /bin/bash -p $(openssl passwd -1 $JENKINS_PASSWORD) $JENKINS_USERNAME

RUN npm install -g n

ENV CI=true
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]