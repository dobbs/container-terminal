FROM jenkins:2.7.1
ENV JAVA_OPTS="-Xmx1024m"
COPY bootstrapMaxrixAuth.groovy /usr/share/jenkins/ref/init.groovy.d/bootstrapMaxrixAuth.groovy
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt
COPY cli /usr/local/bin/cli
