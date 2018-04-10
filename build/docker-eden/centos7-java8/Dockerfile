FROM centos:7.4.1708

RUN yum -y update && \
    yum -y install wget && \
    wget --no-cookies --no-check-certificate \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         "http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm" \
         -O /tmp/jdk-8-linux-x64.rpm && \
    yum -y install /tmp/jdk-8-linux-x64.rpm && \
    rm -f /tmp/jdk-8-linux-x64.rpm && \
    yum clean all
ENV JAVA_HOME /usr/java/latest
ENV JRE_HOME /usr/java/latest/jre
