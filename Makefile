.PHONY: all echo build tag push shell

DOCKER_USER=sleepyfox
IMAGE=elixir-dev
VERSION=1.12-alpine
UID=`id -u`
GID=`id -g`
OS_USER=`whoami`

all: build tag push

echo:
	@ echo "DOCKER_USER set to $(DOCKER_USER)"
	@ echo "IMAGE set to $(IMAGE)"
	@ echo "VERSION set to $(VERSION)"
	@ echo "UID set to $(UID)"
	@ echo "GID set to $(GID)"
	@ echo "OS_USER set to $(OS_USER)"

build:
	docker build \
	--build-arg USER=$(OS_USER) \
	--build-arg UID=$(UID) \
	--build-arg GID=$(GID) \
	-t $(DOCKER_USER)/$(IMAGE):$(VERSION) .

tag:
	docker tag $(DOCKER_USER)/$(IMAGE):$(VERSION) $(DOCKER_USER)/$(IMAGE):latest

push:
	docker push $(DOCKER_USER)/$(IMAGE):$(VERSION)
	docker push $(DOCKER_USER)/$(IMAGE):latest

shell:
	docker run -it \
	-v `pwd`:/var/app \
	$(DOCKER_USER)/$(IMAGE):$(VERSION) \
	ash
