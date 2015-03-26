#!/bin/bash

source /build_environment.sh

# Compile statically linked version of package
echo "Building $pkgName"
CGO_ENABLED=0 go build -a -installsuffix cgo -ldflags '-s' $pkgName
echo "Finished building $pkgName"

if [ -e "/tmp/docker.sock" ]
then
  echo "Image build pre-check. Has Docker Socket"
fi

if [ -e "./Dockerfile" ]
then
  echo "Image build pre-check. Has Dockerfile"
fi

if [ -e "/tmp/docker.sock" ] && [ -e "./Dockerfile" ];
then
  echo "Starting to build docker image"
  # Grab the last segment from the package name
  name=${pkgName##*/}

  # Default TAG_NAME to package name if not set explicitly
  tagName=${tagName:-"$name":latest}

  # Build the image from the Dockerfile in the package directory
  docker -H unix:///tmp/docker.sock build -t $tagName .

  echo "Finished building docker image"
fi
