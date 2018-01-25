FROM ubuntu:artful

# --- configuration section ----------------------
ENV DOCKERIMAGE_HUGO_DOWNLOAD https://github.com/gohugoio/hugo/releases/download/v0.34/hugo_0.34_Linux-64bit.deb
ENV DOCKERIMAGE_NODE_DOWNLOAD https://deb.nodesource.com/setup_9.x


# --- dependencies / installation section --------
RUN apt-get update
RUN apt-get --assume-yes upgrade
RUN apt-get --assume-yes --purge autoremove
RUN apt-get --assume-yes install zsh curl wget git build-essential

RUN curl -sL $DOCKERIMAGE_NODE_DOWNLOAD | bash -
RUN apt-get --assume-yes install nodejs
RUN npm install --unsafe-perm -g html-minifier 
RUN npm install --unsafe-perm -g https://github.com/svg/svgo.git 
RUN npm install --unsafe-perm -g https://github.com/fizker/minifier.git

RUN wget -O /tmp/hugo.deb $DOCKERIMAGE_HUGO_DOWNLOAD
RUN dpkg -i /tmp/hugo.deb

RUN apt-get --assume-yes --purge autoremove
RUN apt-get clean autoclean
