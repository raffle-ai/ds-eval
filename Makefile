MODULE_NAME=$(shell basename $(dir $(abspath $PWD)))

DOCKER_REGISTRY=raffle.azurecr.io

GIT_HASH=$(shell git rev-parse HEAD)
VERSION=v$(shell head -n 1 VERSION)

.PHONY: docker docker-prod docker-prod-push lint test run-local echo-module clean

all: clean lint test

docker:
	docker build \
		-t ${DOCKER_REGISTRY}/${MODULE_NAME}:dev . \
		--build-arg GIT_TOKEN=${GIT_TOKEN} \

docker-prod:
	docker build \
		-t ${DOCKER_REGISTRY}/${MODULE_NAME}:${VERSION} . \
		--build-arg GIT_TOKEN=${GIT_TOKEN}

docker-prod-push:
	docker login ${DOCKER_REGISTRY} -u ${CLIENT_ID} -p ${CLIENT_SECRET}
	docker push ${DOCKER_REGISTRY}/${MODULE_NAME}:${VERSION}

lint:
	poetry run pre-commit install
	poetry run pre-commit run --all-files

test:
	poetry run pytest -v

run-local:
	poetry run python -m api.main --reload --port 8080 --host 0.0.0.0

echo-module:
	@echo ${MODULE_NAME}

echo-version:
	@echo ${VERSION}

