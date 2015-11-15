ConfPath = $(shell pwd)/conf

IMAGE_NAME = scl-mod-merge
TAG = $(IMAGE_NAME):latest
PATH = /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/scripts

RUN = docker run --name $(IMAGE_NAME) -e PATH=$(PATH) -i -t -v $(ConfPath):/conf --rm --net=host $(TAG)

all:
	docker build -t $(TAG) .

run: all
	$(RUN)

bash: all
	$(RUN) /bin/bash
