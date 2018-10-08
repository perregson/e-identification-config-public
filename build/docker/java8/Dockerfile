# Pull base image
FROM ubuntu:16.04

######
# Install tools
######

# Install common tools
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install python-software-properties software-properties-common sudo

# Install Java
COPY jdk-8u151-linux-x64.tar.gz /tmp/
RUN mkdir -p /usr/lib/jvm/ && \
    tar zxvf /tmp/jdk-8u151-linux-x64.tar.gz -C /usr/lib/jvm/ && \
    mv /usr/lib/jvm/jdk1.8.0_151 /usr/lib/jvm/java-8-oracle && \
    rm -f /tmp/jdk-8u151-linux-x64.tar.gz

# enable unlimited JCE policy (java8u151 contains needed jars, but JCE is limited)
RUN sed --in-place "s/#crypto.policy=unlimited/crypto.policy=unlimited/g" /usr/lib/jvm/java-8-oracle/jre/lib/security/java.security

RUN \
  rm -rf /var/lib/apt/lists/* && \
  apt-get clean

# Define JAVA_HOME
RUN update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/java-8-oracle/bin/java" 1 && \
	update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/java-8-oracle/bin/javaws" 1 && \
	update-alternatives --set java "/usr/lib/jvm/java-8-oracle/bin/java" && \
	update-alternatives --set javaws "/usr/lib/jvm/java-8-oracle/bin/javaws"
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH="/usr/lib/jvm/java-8-oracle/bin:${PATH}"
