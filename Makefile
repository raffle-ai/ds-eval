MODULE_NAME=ds-repo-template

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

deps:
	poetry config installer.parallel false
	poetry install

test:
	poetry run pytest -v

run-local:
	poetry run python -m template.api --reload

echo-module:
	@echo ${MODULE_NAME}

echo-version:
	@echo ${VERSION}

check-commit-messages:
	branch=$$(git rev-parse --abbrev-ref HEAD); \
	if [ $$branch != "main" ] && [ $$branch != "master" ]; then \
		cz check --rev-range main..HEAD; \
	else \
		echo "Skipping because of main or master branch"; \
	fi
