DOCKERHOST = docker.io
DOCKERORG = java-starter-guides
IMAGENAME = java-starter-guides
TAG = latest
USER=$(shell id -u)
PWD=$(shell pwd)
build_and_push: apb_build docker_push apb_push

.PHONY: apb_build
apb_build:
	apb prepare
	docker build -t $(DOCKERHOST)/$(DOCKERORG)/$(IMAGENAME):$(TAG) .

.PHONY: docker_push
docker_push:
	docker push $(DOCKERHOST)/$(DOCKERORG)/$(IMAGENAME):$(TAG)

.PHONY: apb_push
apb_push:
	apb push