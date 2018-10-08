FROM e-identification-docker-virtual.vrk-artifactory-01.eden.csc.fi/e-identification-base-centos7-java

RUN groupadd tomcat
RUN useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
COPY apache-tomcat-8.0.51.tar.gz /tmp/
RUN mkdir /opt/tomcat
RUN tar xvf /tmp/apache-tomcat-8.0.51.tar.gz -C /opt/tomcat --strip-components=1
RUN chgrp -R tomcat /opt/tomcat
RUN chmod -R g+r /opt/tomcat/conf
RUN chmod g+x /opt/tomcat/conf
RUN chown -R tomcat /opt/tomcat/webapps/ \
                    /opt/tomcat/work/ \
                    /opt/tomcat/temp/ \
                    /opt/tomcat/logs/

RUN curl -o /etc/yum.repos.d/shibboleth.repo http://download.opensuse.org/repositories/security://shibboleth/CentOS_7/security:shibboleth.repo

RUN yum install -y httpd mod_ssl shibboleth 
