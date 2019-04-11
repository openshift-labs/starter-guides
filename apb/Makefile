IMAGENAME = starter-workshop-apb
TAG = latest
USER=$(shell id -u)
PWD=$(shell pwd)
build_and_push: apb_build

.PHONY: apb_build
apb_build:
  apb bundle prepare
  docker build -t $(IMAGENAME):$(TAG) .
