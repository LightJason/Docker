FROM ubuntu:bionic

# --- configuration section ----------------------
ENV DOCKERIMAGE_MAVEN_VERSION 3.5.2
ENV DOCKERIMAGE_SAXON_JAR saxon9he.jar
ENV DOCKERIMAGE_JAVA_DOWNLOAD http://download.oracle.com/otn-pub/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_linux-x64_bin.tar.gz
ENV DOCKERIMAGE_SAXON_DOWNLOAD https://sourceforge.net/projects/saxon/files/Saxon-HE/9.8/SaxonHE9-8-0-4J.zip/download


# --- dependencies section -----------------------
ENV JAVA_HOME /opt/java
ENV GOPATH /opt/go

RUN mkdir -p $GOPATH
RUN mkdir -p $JAVA_HOME
RUN apt-get --yes update
RUN apt-get --yes upgrade
RUN apt-get --yes install apt-utils golang git doxygen graphviz unzip xsltproc wget
RUN apt-get --yes --purge autoremove
RUN wget -O /tmp/saxon.zip $DOCKERIMAGE_SAXON_DOWNLOAD && mkdir -p /opt/saxon && unzip -d /usr/local/bin/ /tmp/saxon.zip $DOCKERIMAGE_SAXON_JAR
RUN wget -O /tmp/java.tar.gz --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" $DOCKERIMAGE_JAVA_DOWNLOAD && tar --strip 1 -zxvf /tmp/java.tar.gz -C $JAVA_HOME
RUN wget -O /tmp/maven.tar.gz http://archive.apache.org/dist/maven/maven-3/$DOCKERIMAGE_MAVEN_VERSION/binaries/apache-maven-$DOCKERIMAGE_MAVEN_VERSION-bin.tar.gz && mkdir -p /opt/maven && tar --strip 1 -zxvf /tmp/maven.tar.gz -C /opt/maven
RUN go get -u github.com/tcnksm/ghr
RUN echo -n "#!/bin/bash\nSRC=\$(dirname \$0)\njava -jar \$SRC/$DOCKERIMAGE_SAXON_JAR \$@\n" > /usr/local/bin/saxon
RUN chmod a+x /usr/local/bin/saxon

ENV PATH $GOPATH/bin:$JAVA_HOME/bin:/opt/maven/bin:$PATH
