.PHONY: help images .valid build test deploy deploy-ci
.DEFAULT_GOAL: help

SHELL := /bin/bash

DOCKER_HUB_USER := patouche

ALL_IMAGES := $(sort $(foreach d,$(wildcard */Dockerfile),$(d:/Dockerfile=)))

help:  ## Help me !
	@echo "==> [INFO] Help me !"
	@echo "Target :"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  - \033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo "Images :"
	@echo "$(ALL_IMAGES)" | awk -v RS=' +' '{printf "  - \033[36m%-30s\033[0m\n", $$1}'

images: ## List all images folders
	@echo "==> [INFO] Image folders"
	@echo "$(ALL_IMAGES)" | awk -v RS=' +' '{printf "  - \033[36m%-30s\033[0m\n", $$1}'

.valid:
	@if [ ! -e $(folder)/Dockerfile ]; then echo "[ERROR] Image '$(folder)' is not valid. Use a valid image" >&2; exit 1; fi
	@if [ ! -e $(folder)/tags.txt ]; then echo "[ERROR] Folder '$(folder)' should contains a 'tags.txt' file" >&2; exit 1; fi

build: .valid ## Build docker image [folder: the folder name of image to build]
	# img : the folder name of the image to build
	@echo "==> [INFO] Build docker image : $(folder)"
	@cd $(folder); \
		while IFS= read -r line; do \
			tags=($${line%%:*}); tags=$${tags[@]/#/--tag $(DOCKER_HUB_USER)/$(folder):}; \
			build_args=($${line#*:}); build_args=$${build_args[@]/#/--build-arg }; \
			docker build $${tags} $${build_args} . ; \
		done < tags.txt

test: build ## Test the docker image with bats [folder: the folder name of image to build]
	@echo "==> [INFO] Testing docker image : $(folder) using bats (https://github.com/bats-core/bats-core)"
	@while IFS= read -r line; do \
		tag=$${line%% *}; \
		if [ -e $(folder)/tests/$${tag} ] ; then \
			echo "==> [INFO] Running test for image $(DOCKER_HUB_USER)/$(folder):$${tag} (folders=[$(folder)/tests/__all $(folder)/tests/$${tag}])"; \
			IMAGE_NAME="$(DOCKER_HUB_USER)/$(folder):$${tag}" bats -t $(folder)/tests/__all $(folder)/tests/$${tag}; \
		else echo "==> [WARNING] No tests for image '$(DOCKER_HUB_USER)/$(folder):$${tag}'. Should be found in folder '$(folder)/tests/$${tag}'"; fi \
	done < $(folder)/tags.txt

deploy: test ## Deploy a docker image [folder: the folder name of image to build]
	@echo "==> [INFO] Deploy Image : $(folder)"
	@while IFS= read -r line; do \
		tags=($${line%%:*}); \
		for t in $${tags[@]}; do docker push "$(DOCKER_HUB_USER)/$(folder):$${t}"; done; \
	done < $(folder)/tags.txt

deploy-ci: test ## Deploy a docker image [folder: the folder name of image to build]
	@echo "==> [INFO] Deploy CI Image : $(folder)"
	@echo "$${DOCKER_PASSWORD}" | docker login -u "$(DOCKER_HUB_USER)" --password-stdin;
	@$(MAKE) deploy img='$(folder)';

docker-clean: ## Remove all images for current user
	@echo "==> [INFO] Cleaning docker images for user $(DOCKER_HUB_USER)"
	@docker rmi $$(docker image ls --filter=reference='$(DOCKER_HUB_USER)/*' -q)
	@docker rmi $$(docker image ls --filter=dangling=true -q)
