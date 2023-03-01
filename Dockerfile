FROM ubuntu:18.04
#Change this to the version of samtools you want to install
ARG version=1.17
LABEL version=$version
LABEL description="Samtools"

MAINTAINER John Kitonyo <jkitonyo@broadinstitute.org>

RUN apt-get update && apt-get -y upgrade && \
	apt-get install -y build-essential wget \
		libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libcurl3-dev && \
	apt-get clean && apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src

#Samtools
RUN wget https://github.com/samtools/samtools/releases/download/$version/samtools-$version.tar.bz2 && \
	tar jxf samtools-$version.tar.bz2 && \
	rm samtools-$version.tar.bz2 && \
	cd samtools-$version && \
	./configure --prefix $(pwd) && \
	make

ENV PATH=${PATH}:/usr/src/samtools-$version
