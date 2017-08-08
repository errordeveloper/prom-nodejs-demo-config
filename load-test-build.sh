#!/bin/sh

docker run --rm -ti \
  -v $(pwd):$(pwd) \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -w $(pwd) \
    boxbuilder/box:master load-test-build.rb

docker push docker.io/errordeveloper/prom-nodejs-demo-load-test:slow
docker push docker.io/errordeveloper/prom-nodejs-demo-load-test:fast
