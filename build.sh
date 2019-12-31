#!/bin/bash

echo "build image..."
docker build -t codlin/gotools:1.13.5 .
echo "done"
