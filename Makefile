# Set the name of your Docker image
DOCKER_IMAGE_NAME := mdbtools-rest

# Set the version of your Docker image
DOCKER_IMAGE_VERSION := 1.0.0

# Set the name of your Docker container
DOCKER_CONTAINER_NAME := mdbtools-rest

# Set the port that your application will run on
DOCKER_CONTAINER_PORT := 5000

# Set the port that your application will extend on
DOCKER_CONTAINER_PORT_EXTENDED := 3000

# Set the path to your application's source code
APP_SRC_DIR := ./

# Set the path to your Dockerfile
DOCKERFILE := ./Dockerfile

# Set the path to the saved Docker image file
DOCKER_IMAGE_FILE := mdbtools-rest.tar

.PHONY: run build deploy clean

run: ## Run the application in a Docker container
	docker run -d --name $(DOCKER_CONTAINER_NAME) -p $(DOCKER_CONTAINER_PORT_EXTENDED):$(DOCKER_CONTAINER_PORT) $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

build: ## Build the Docker image
	docker build -t $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION) -t $(DOCKER_IMAGE_NAME):latest -f $(DOCKERFILE) $(APP_SRC_DIR)

deploy: ## Deploy the Docker image by saving it to a file
	docker image save $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION) | gzip > $(DOCKER_IMAGE_NAME)_$(DOCKER_IMAGE_VERSION).tar.gz

clean: ## Remove the Docker container and image

	docker rmi $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)
	rm -f $(DOCKER_IMAGE_FILE)*

help: ## Display this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'