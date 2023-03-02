MODULE_NAME=ds-repo-template

DOCKER_REGISTRY=raffle.azurecr.io

GIT_HASH=$(shell git rev-parse HEAD)
VERSION=$(shell head -n 1 VERSION)

.PHONY: docker clean lint test

all: clean lint test

container:
	docker build -t ${DOCKER_REGISTRY}/${MODULE_NAME}:dev --build-arg GIT_HASH=${GIT_HASH} .

docker:
	docker build -t ${DOCKER_REGISTRY}/${MODULE_NAME}:dev .

docker-prod:
	docker build -t ${DOCKER_REGISTRY}/${MODULE_NAME}:${GIT_HASH} .

docker-prod-push:
	docker push ${DOCKER_REGISTRY}/${MODULE_NAME}:${GIT_HASH}

lint:
	poetry run pre-commit install
	poetry run pre-commit run --all-files

test:
	poetry run pytest

