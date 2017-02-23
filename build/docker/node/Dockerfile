# Pull base image
FROM ubuntu:14.04

######
# Install node and tools
######

# Update packages
# Install some packages we need
# Install Node.JS
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y curl && \
    apt-get install -y git && \
    cd /usr/local && \
    curl https://nodejs.org/dist/v6.3.0/node-v6.3.0-linux-x64.tar.gz | tar --strip-components=1 -zxf- && cd && \
    npm -g update npm

######
# Create directories
######

# Logging dir
ENV log_dir /data00/work/logs
RUN mkdir -p ${log_dir}

# Define working directory
ENV deploy_dir /data00/deploy/
RUN mkdir -p ${deploy_dir}
WORKDIR ${deploy_dir}
