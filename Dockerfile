FROM golang:1.13.5

ENV LD_LIBRARY_PATH /usr/local/lib
ENV GO111MODULE=off

# Install packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends tcl tk expect
    
RUN git clone https://github.com/golang/lint.git $GOPATH/src/golang.org/x/lint　\
    && go get -u github.com/golang/protobuf/protoc-gen-go \
    && go install github.com/golang/protobuf/protoc-gen-go \
    && go get -u google.golang.org/grpc \
    && go install google.golang.org/grpc \
    && go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway \
    && go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway \
    && go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger \
    && go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.11.2/protobuf-all-3.11.2.tar.gz \
    && tar -C /usr/local -zxf protobuf-all-*.tar.gz \
    && cd /usr/local/protobuf-* \
    &&  ./configure && make && make install \
    && rm -rf /go/protobuf-all-*.tar.gz && rm -rf /usr/local/protobuf-* \
    && rm -f /usr/local/lib/libproto*.a && rm -f /usr/local/lib/libproto*.la \
    && cd /go && wget https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz \
    && tar zxvf docker-latest.tgz \
    && cp docker/docker /usr/local/bin/ \
    && rm -rf docker docker-latest.tgz
