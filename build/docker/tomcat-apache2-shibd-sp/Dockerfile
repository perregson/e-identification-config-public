# Pull base image
FROM e-identification-docker-virtual.vrk-artifactory-01.eden.csc.fi/e-identification-tomcat-base-image

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y apache2 libapache2-mod-shib2 opensaml2-tools libshibsp-doc shibboleth-sp2-schemas libshibsp-dev && \
  a2enmod proxy_ajp && \
  a2enmod proxy && \
  a2enmod proxy_http && \
  a2enmod shib2 && \
  a2enmod ssl

CMD tail -f /dev/null
