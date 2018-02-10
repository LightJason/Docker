# LightJason - Docker

![Docker](https://img.shields.io/docker/build/lightjason/docker.svg)

The LightJason Docker container is build for any developing strucutre of the whole LightJason frameworks and additional components. The container is splitted up into different section with different build environment

## Java Development

Docker container with a Java Development Framework (JDK) and additional tools

Tags: ```jdk```

* [Rolling Ubuntu Linux](https://hub.docker.com/_/ubuntu/)
* [Oracle JDK 9](http://www.oracle.com/technetwork/java/javase/downloads/jdk9-downloads-3848520.html)
* [Maven 3.5.2](https://maven.apache.org/)
* [Saxon HE 9](http://saxon.sourceforge.net/)
* [GHR](http://deeeet.com/ghr/) for Github release building
* Git Client, Xsltproc, Doxygen, Graphviz, Curl, Wget, Perl and Go are included

## LaTeX Development

Docker container with a TeX-Live build. This container stores a complete installation of the LaTeX distribution with additional tools

Tags: ```tex```

* [Alpine Linux 3.7](https://alpinelinux.org/)
* [TeX-Live](https://www.tug.org/texlive/) LaTeX distribution
* [LaTeXMK](https://ctan.org/pkg/latexmk) configuration for building PDF with glossary and mpost
* Git Client with OpenSSH support, Curl, Wget, Perl, GnuPG and Go are included
* [GHR](http://deeeet.com/ghr/) is included to create GitHub release structure

## Webpage Development

Docker container for building static webpages

Tags: ```web```

* [Ubuntu Linux](https://wiki.ubuntuusers.de/Bionic_Beaver/)
* [Hugo](https://gohugo.io/)
* [Node.JS](https://nodejs.org) with global modules
	* [SVGO](https://github.com/svg/svgo)
	* [Minifier](https://github.com/fizker/minifier)
	* [HTML-Minifier](https://github.com/kangax/html-minifier)
