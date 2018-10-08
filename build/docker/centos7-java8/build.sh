#!/bin/bash
docker pull centos:7.4.1708
docker build -t e-identification-docker-virtual.vrk-artifactory-01.eden.csc.fi/e-identification-base-centos7-java .
