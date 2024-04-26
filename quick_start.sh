#!/bin/sh
docker build . -t tutorial
docker run -d -p 8080:80 tutorial