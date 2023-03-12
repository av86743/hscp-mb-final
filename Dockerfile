FROM	ubuntu:bionic

ARG	DEBIAN_FRONTEND=noninteractive

#  package list per <https://docs.haskellstack.org/en/stable/install_and_upgrade/>
#    Manual download -> Ubuntu

RUN	sh -ex; \
	apt-get -qq update; \
	apt-get -qq install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		libffi-dev \
		libgmp-dev \
		make \
		xz-utils \
		zlib1g-dev \
		git \
		gnupg \
		netbase \
		\
		curl \
		ca-certificates \
	;:

ARG	STACKVER=2.9.1
ARG	GHCVER=9.2.5

RUN	sh -ex; \
	SD='stack-'"$STACKVER"'-linux-x86_64-static'; \
	TGZ="$SD"'.tar.gz'; \
	URL='https://github.com/commercialhaskell/stack/releases/download/v'"$STACKVER"'/'"$TGZ"; \
	echo "$URL"; \
	curl -sL "$URL" | tar xzC /opt; \
	ln -s /opt/"$SD"/stack /usr/local/bin/; \
	:

WORKDIR	/hscp-mb

ADD	. .

RUN	sh -ex; \
	stack --version; \
	exec 2>&1; \
	echo "::: stack setup :::" `date +%H:%M:%S`; \
	stack setup; \
	echo "::: stack build :::" `date +%H:%M:%S`; \
	stack build; \
	echo "::: stack test :::" `date +%H:%M:%S`; \
	stack test; \
	echo "::: stack done :::" `date +%H:%M:%S`; \
	:

RUN	sh -ex; \
	stack --version; \
	stack query; \
	du -kscx $HOME/.stack .stack-work .; \
	:
