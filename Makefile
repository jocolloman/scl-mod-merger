ConfPath = $(shell pwd)/conf

IMAGE_NAME = scl-mod-merge
TAG = $(IMAGE_NAME):latest

RUN = docker run --name $(IMAGE_NAME) -i -t -v $(ConfPath):/conf --rm --net=host $(TAG)

all:
	docker build -t $(TAG) .

run: all
	$(RUN)

bash: all
	$(RUN) /bin/bash
