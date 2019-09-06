.PHONY: help images .valid build test deploy deploy-ci
.DEFAULT_GOAL: help

SHELL := /bin/bash

DOCKER_HUB_USER := patouche

ALL_IMAGES := $(sort $(foreach d,$(wildcard */Dockerfile),$(d:/Dockerfile=)))

help:  ## Help me !
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

build: .valid ## Build docker image [img: the folder name of image to build]
	@echo "==> Build docker image : $(img)"
	@cd $(img); \
		while IFS= read -r line; do \
			tags=($${line%%:*}); tags=$${tags[@]/#/--tag $(DOCKER_HUB_USER)/$(img):}; \
			build_args=($${line#*:}); build_args=$${build_args[@]/#/--build-arg }; \
			docker build $${tags} $${build_args} . ; \
		done < tags.txt

test: build ## Test the docker image with bats [img: the folder name of image to build]
	@echo "==> Testing docker image : $(img) using bats (https://github.com/bats-core/bats-core)"
	@cd $(img); \
		IMAGE_NAME="$(DOCKER_HUB_USER)/$(img):latest" bats -t tests/

deploy: test ## Deploy a docker image [img: the folder name of image to build]
	@echo "==> Deploy Image : $(img)"
	@docker push "$(DOCKER_HUB_USER)/$(img):$$(cat $(img)/version.txt)
	@docker push "$(DOCKER_HUB_USER)/$(img):latest

deploy-ci: test
	@echo "==> Deploy CI Image : $(img)"
	@echo "$${DOCKER_PASSWORD}" | docker login -u "$(DOCKER_HUB_USER)" --password-stdin; \
	while IFS= read -r line; do \
			tags=($${line%%:*}); \
			for t in $${tags[@]}; do docker push "$(DOCKER_HUB_USER)/$(img):$${t}"; done; \
		done < $(img)/tags.txt

docker-clean: ## Remove all images for current user
	@echo "==> Cleaning docker images for user $(DOCKER_HUB_USER)"
	@docker rmi $$(docker image ls --filter=reference='$(DOCKER_HUB_USER)/*' -q)
	@docker rmi $$(docker image ls --filter=dangling=true -q)
