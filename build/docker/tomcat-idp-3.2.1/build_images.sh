#!/bin/bash
docker build --no-cache -f Dockerfile -t dev-docker-registry.kapa.ware.fi/e-identification-tomcat-idp-3.2.1-base-image .
docker push dev-docker-registry.kapa.ware.fi/e-identification-tomcat-idp-3.2.1-base-image
