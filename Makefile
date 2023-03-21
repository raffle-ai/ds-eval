MODULE_NAME=$(shell basename $(dir $(abspath $PWD)))

DOCKER_REGISTRY=raffle.azurecr.io

GIT_HASH=$(shell git rev-parse HEAD)
VERSION=v$(shell head -n 1 VERSION)

.PHONY: clean docker docker-prod docker-prod-push lint test run-local echo-module echo-version

all: clean lint test

docker:
	docker build -t ${DOCKER_REGISTRY}/${MODULE_NAME}:dev --build-arg GIT_HASH=${GIT_HASH} .

docker-prod:
	docker build -t ${DOCKER_REGISTRY}/${MODULE_NAME}:v${VERSION} .

docker-prod-push:
	docker push ${DOCKER_REGISTRY}/${MODULE_NAME}:v${VERSION}

lint:
	poetry run pre-commit install
	poetry run pre-commit run --all-files

test:
	poetry run pytest

run-local:
	poetry run python -m api.main --reload --port 8080 --host 0.0.0.0

echo-module:
	@echo ${MODULE_NAME}

echo-version:
	@echo ${VERSION}
