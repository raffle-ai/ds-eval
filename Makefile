MODULE_NAME=$(shell basename $(dir $(abspath $PWD)))

DOCKER_REGISTRY=raffle.azurecr.io

GIT_HASH=$(shell git rev-parse HEAD)
VERSION=v$(shell head -n 1 VERSION)

.PHONY: container docker docker-prod docker-prod-push lint test echo-module clean

all: clean lint test

container:
	docker build -t ${DOCKER_REGISTRY}/${MODULE_NAME}:dev --build-arg GIT_HASH=${GIT_HASH} .

docker:
	docker build -t ${DOCKER_REGISTRY}/${MODULE_NAME}:dev .

docker-prod:
	docker build -t ${DOCKER_REGISTRY}/${MODULE_NAME}:${VERSION} .

docker-prod-push:
	docker push ${DOCKER_REGISTRY}/${MODULE_NAME}:${VERSION}

lint:
	poetry run pre-commit install
	poetry run pre-commit run --all-files

test:
	poetry run pytest

echo-module:
	@echo ${MODULE_NAME}

echo-version:
	@echo ${VERSION}
