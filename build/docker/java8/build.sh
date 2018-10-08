#!/bin/bash
docker pull ubuntu:16.04
docker build -t e-identification-docker-virtual.vrk-artifactory-01.eden.csc.fi/e-identification-base-java-service .
