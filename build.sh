#!/bin/bash

echo "build image..."
docker build -t go-tools:1.12.9 .
echo "done"