#!/bin/bash
docker pull node:10-stretch
docker build -t e-identification-docker-virtual.vrk-artifactory-01.eden.csc.fi/e-identification-base-node .
