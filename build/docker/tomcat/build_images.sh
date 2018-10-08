#!/bin/bash
docker pull e-identification-docker-virtual.vrk-artifactory-01.eden.csc.fi/e-identification-base-java-service
docker build --no-cache -f Dockerfile -t e-identification-docker-virtual.vrk-artifactory-01.eden.csc.fi/e-identification-tomcat-base-image .
