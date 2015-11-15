ConfPath = $(shell pwd)/conf

TAG = scl-rating:latest

RUN = docker run --name scl-mod-merger -i -t -v $(SharedPath):/conf --rm --net=host $(TAG)

all:
	docker build -t $(TAG) .

run: all
	$(RUN)

bash: all
	$(RUN) /bin/bash
