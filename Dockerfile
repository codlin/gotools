FROM golang:1.12.9

USER root
ENV GOPATH /go
ENV PATH ${GOPATH}/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/lib

# Install packages
RUN go get -u golang.org/x/lint/golint
RUN go get -u github.com/golang/protobuf/protoc-gen-go
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.9.1/protobuf-all-3.9.1.tar.gz \
    && tar -C /usr/local -zxf protobuf-all-3.9.1.tar.gz \
    && cd /usr/local/protobuf-* \
    &&  ./configure && make && make install \
    && rm -rf /go/protobuf-all-3.9.1.tar.gz && rm -rf /usr/local/protobuf-* \
    && rm -f /usr/local/lib/libproto*.a && rm -f /usr/local/lib/libproto*.la \
    && cd /go && wget https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz \
    && tar zxvf docker-latest.tgz \
    && cp docker/docker /usr/local/bin/ \
    && rm -rf docker docker-latest.tgz

# install expect
RUN apt-get update
RUN apt-get -y install tcl tk expect

RUN go get -u github.com/golang/protobuf/proto && go get install github.com/golang/protobuf/proto \
    && go get -u github.com/micro/protoc-gen-micro && go get install github.com/micro/protoc-gen-micro
