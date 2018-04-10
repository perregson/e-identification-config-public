# Pull base image
FROM e-identification-docker-virtual.vrk-artifactory-01.eden.csc.fi/e-identification-tomcat-base-image

ADD shibboleth-identity-provider-3.2.1-post-binding.tar.gz /usr/local/src/
RUN ln -sf /usr/local/src/shibboleth-identity-provider-3.2.1 /usr/local/src/shibboleth-identity-provider
COPY jstl-1.2.jar /usr/share/tomcat/lib/jstl-1.2.jar

