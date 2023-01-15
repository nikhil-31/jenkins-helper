FROM jenkins/jenkins:2.375.2
LABEL maintainer=”supreme@lol.com”

ARG user=jenkins

USER root
RUN mkdir /var/log/jenkins
# RUN mkdir /var/cache/jenkins
RUN chown -R  jenkins:jenkins /var/log/jenkins
RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
# RUN chown -R jenkins:jenkins /var/cache/jenkins

USER jenkins

ENV JAVA_OPTS="-Xmx8192m"
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log"