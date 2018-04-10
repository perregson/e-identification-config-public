FROM centos:7.4.1708

COPY jdk-8u151-linux-x64.rpm /tmp/

# install Java
RUN yum -y update && \
    yum -y install /tmp/jdk-8u151-linux-x64.rpm && \
    rm -f /tmp/jdk-8u151-linux-x64.rpm && \
    yum clean all

# enable unlimited JCE policy (java8u151 contains needed jars, but JCE is limited)
RUN sed --in-place "s/#crypto.policy=unlimited/crypto.policy=unlimited/g" /usr/java/latest/jre/lib/security/java.security

ENV JAVA_HOME /usr/java/latest
ENV JRE_HOME /usr/java/latest/jre
