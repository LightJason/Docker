FROM alpine:3.7

# --- configuration section ----------------------
ENV DOCKERIMAGE_MAVEN_VERSION 3.5.2
ENV DOCKERIMAGE_GLIBC_VERSION 2.26-r0
ENV DOCKERIMAGE_JAVA_DOWNLOAD http://download.oracle.com/otn-pub/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_linux-x64_bin.tar.gz
ENV DOCKERIMAGE_SAXON_DOWNLOAD https://sourceforge.net/projects/saxon/files/Saxon-HE/9.8/SaxonHE9-8-0-4J.zip/download
ENV DOCKERIMAGE_SAXON_JAR saxon9he.jar


# --- dependencies section -----------------------
RUN wget -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub
RUN wget -O /tmp/glibc.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$DOCKERIMAGE_GLIBC_VERSION/glibc-$DOCKERIMAGE_GLIBC_VERSION.apk
RUN wget -O /tmp/glibc-bin.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$DOCKERIMAGE_GLIBC_VERSION/glibc-bin-$DOCKERIMAGE_GLIBC_VERSION.apk
RUN wget -O /tmp/glibc-i18n.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$DOCKERIMAGE_GLIBC_VERSION/glibc-i18n-$DOCKERIMAGE_GLIBC_VERSION.apk

RUN wget -O /tmp/saxon.zip $DOCKERIMAGE_SAXON_DOWNLOAD && mkdir -p /opt/saxon && unzip -d /opt/saxon/ /tmp/saxon.zip $DOCKERIMAGE_SAXON_JAR

RUN wget -O /tmp/maven.tar.gz http://archive.apache.org/dist/maven/maven-3/$DOCKERIMAGE_MAVEN_VERSION/binaries/apache-maven-$DOCKERIMAGE_MAVEN_VERSION-bin.tar.gz && mkdir -p /opt/maven && tar --strip 1 -zxvf /tmp/maven.tar.gz -C /opt/maven
RUN wget -O /tmp/java.tar.gz --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" $DOCKERIMAGE_JAVA_DOWNLOAD && mkdir -p /opt/java && tar --strip 1 -zxvf /tmp/java.tar.gz -C /opt/java


RUN apk --no-cache update &&\
    apk --no-cache upgrade &&\
    apk --no-cache add go musl-dev git doxygen graphviz libxslt openssh-client ca-certificates /tmp/glibc.apk /tmp/glibc-bin.apk /tmp/glibc-i18n.apk
RUN /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8
RUN go get -u github.com/tcnksm/ghr
RUN echo -e "#!/bin/sh -e\nSRC=\$(dirname \$0)\njava -jar \$SRC/$DOCKERIMAGE_SAXON_JAR \$@\n" > /opt/saxon/saxon
RUN chmod a+x /opt/saxon/saxon

ENV JAVA_HOME /opt/java
ENV PATH /root/go/bin:/opt/saxon:/opt/maven/bin:$JAVA_HOME/bin:$PATH
