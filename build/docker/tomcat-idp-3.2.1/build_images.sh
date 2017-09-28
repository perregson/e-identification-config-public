#!/bin/bash
./build_shibboleth_tar.sh
docker build --no-cache -f Dockerfile -t dev-docker-registry.kapa.ware.fi/e-identification-tomcat-idp-3.2.1-base-image:v2 .
docker push dev-docker-registry.kapa.ware.fi/e-identification-tomcat-idp-3.2.1-base-image:v2
rm shibboleth-identity-provider-3.2.1-post-binding.tar.gz
