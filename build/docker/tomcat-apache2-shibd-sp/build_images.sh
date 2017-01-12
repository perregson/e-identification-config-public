#!/bin/bash
docker build --no-cache -f Dockerfile -t dev-docker-registry.kapa.ware.fi/e-identification-tomcat-apache2-shibd-sp-base-image .
docker push dev-docker-registry.kapa.ware.fi/e-identification-tomcat-apache2-shibd-sp-base-image
