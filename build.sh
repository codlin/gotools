#!/bin/bash

echo "build image..."
docker build -t codlin/gotools:1.12.9 .
echo "done"