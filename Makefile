# Go parameters
GOCMD=GO111MODULE=on go
GOBUILD=$(GOCMD) build
DBUILD=docker build
DOCKER_NS ?= fabric-relayer
DOCKER_TAG=1.0


relayer:
	$(GOBUILD) -o build/bin/relayer cmd/*

build-linux:
	GOOS=linux GOARCH=amd64 $(GOBUILD) -o build/bin/relayer-linux cmd/*

run:
	./build/bin/relayer --cliconfig=build/config/config.json --logdir=build/logger/ --loglevel=1 --poly=0 --fabric=3

runNode1:
	go run cmd/* --cliconfig=build/node1/config.json --logdir=build/node1/logger/ --loglevel=1 --poly=0 --fabric=3

runNode2:
	go run cmd/* --cliconfig=build/node2/config.json --logdir=build/node2/logger/ --loglevel=1 --poly=0 --fabric=3

clean:
	rm -rf build/bin/*

images: Makefile
	@echo "Building relayer docker image - $(DOCKER_TAG)"
	@$(DBUILD) --no-cache -f Dockerfile -t $(DOCKER_NS):$(DOCKER_TAG) .
	@docker tag $(DOCKER_NS):$(DOCKER_TAG) $(DOCKER_NS):latest