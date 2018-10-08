#!/bin/bash
./build_shibboleth_tar.sh
docker pull e-identification-docker-virtual.vrk-artifactory-01.eden.csc.fi/e-identification-tomcat-base-image
docker build --no-cache -f Dockerfile -t e-identification-docker-virtual.vrk-artifactory-01.eden.csc.fi/e-identification-tomcat-idp-3.2.1-base-image:v2 .
rm shibboleth-identity-provider-3.2.1-post-binding.tar.gz
