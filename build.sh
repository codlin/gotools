#!/bin/bash

echo "build image..."
docker build -t codlin/go-tools:1.12.9 .
echo "done"