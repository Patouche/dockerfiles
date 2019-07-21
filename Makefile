.PHONY: help images build test deploy
.DEFAULT_GOAL: help

SHELL := /bin/bash

DOCKER_HUB_USER := patouche

ALL_IMAGES := $(sort $(foreach d,$(wildcard */Dockerfile),$(d:/Dockerfile=)))

help:  ## Help
	@echo "==> Help me !"
	@echo "Target :"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  - \033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo "Images :"
	@echo "$(ALL_IMAGES)" | awk -v RS=' +' '{printf "  - \033[36m%-30s\033[0m\n", $$1}'

images: ## List all images
	@echo "==> Images"
	@echo "$(ALL_IMAGES)" | awk -v RS=' +' '{printf "  - \033[36m%-30s\033[0m\n", $$1}'

.valid:
	@if [ ! -e $(img)/Dockerfile ]; then echo "Error: Image '$(img)' is not valid. Use a valid image"; exit 1; fi

build: .valid ## Build docker image
	@echo "==> Build docker image : $(img)"
	@cd $(img); docker build -t $(DOCKER_HUB_USER)/$(img):$$(cat version.txt) -t $(DOCKER_HUB_USER)/$(img):latest .

test: build ## Test the docker image with
	@echo "==> Testing docker image : $(img) using bats (https://github.com/bats-core/bats-core)"
	@cd $(img); IMAGE_NAME="$(DOCKER_HUB_USER)/$(img):latest" bats -t test.bats

deploy: test ## Deploy a docker image
	@echo "==> Deploy Image : $(img)"
	@docker push "$(DOCKER_HUB_USER)/$(img):$$(cat $(img)/version.txt)
	@docker push "$(DOCKER_HUB_USER)/$(img):latest

deploy-ci: test
	@echo "==> Deploy CI Image : $(img)"
	@( \
		echo "$${DOCKER_PASSWORD}" | docker login -u "$(DOCKER_HUB_USER)" --password-stdin; \
		docker push "$(DOCKER_HUB_USER)/$(img):$$(cat $(img)/version.txt)"; \
		docker push "$(DOCKER_HUB_USER)/$(img):latest"; \
	)