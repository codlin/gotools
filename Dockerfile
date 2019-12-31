FROM golang:1.13.5-alpine3.11

ENV LD_LIBRARY_PATH /usr/local/lib
ENV GO111MODULE=off
ENV GOPROXY="https://goproxy.cn,direct"

# Install packages
RUN apk update \
    && apk install -y --no-install-recommends tcl tk expect unzip git
    
RUN go get -u golang.org/x/lint/golint && go install golang.org/x/lint/golint \
    && go get -u github.com/golang/protobuf/protoc-gen-go \
    && go install github.com/golang/protobuf/protoc-gen-go \
    && go get -u google.golang.org/grpc \
    && go install google.golang.org/grpc \
    && go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway \
    && go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway \
    && go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger \
    && go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger

RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.11.2/protoc-3.11.2-linux-x86_64.zip \
    && unzip protoc-3.11.2-linux-x86_64.zip -d ~/protoc \
    && cp -rf ~/protoc/bin/* /usr/local/bin/ && cp -rf ~/protoc/include/* /usr/local/include/ && rm -rf protoc* \
    && cd /go && wget https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz \
    && tar zxvf docker-latest.tgz \
    && cp docker/docker /usr/local/bin/ \
    && rm -rf docker docker-latest.tgz
