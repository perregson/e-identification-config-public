# Pull base image
FROM node:10-stretch

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
