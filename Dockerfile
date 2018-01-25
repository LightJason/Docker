FROM lightjason/docker:jdk

# --- configuration section ----------------------
ENV DOCKERIMAGE_NODE_DOWNLOAD https://deb.nodesource.com/setup_9.x


# --- dependencies section -----------------------
RUN curl -sL $DOCKERIMAGE_NODE_DOWNLOAD | bash -
RUN apt-get --assume-yes install nodejs
