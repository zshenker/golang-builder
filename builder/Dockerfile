FROM golang:1.4.1
MAINTAINER CenturyLink Labs <clt-labs-futuretech@centurylink.com>

# Install Docker binary
RUN wget -nv https://get.docker.com/builds/Linux/x86_64/docker-1.4.1 -O /usr/bin/docker && \
  chmod +x /usr/bin/docker

VOLUME /src
WORKDIR /src

COPY build_environment.sh /
COPY build.sh /

ENTRYPOINT ["/build.sh"]
