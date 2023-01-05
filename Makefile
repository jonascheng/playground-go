.DEFAULT_GOAL := help

APPLICATION?=playground-go
# is Windows_NT on XP, 2000, 7, Vista, 10...
ifeq ($(OS),Windows_NT)
GOOS?=windows
RACE=""
else
GOOS?=$(shell uname -s | awk '{print tolower($0)}')
GORACE="-race"
endif

.PHONY: setup
setup: ## setup go modules
	go mod tidy

.PHONY: clean
clean: ## cleans the binary
	go clean
	rm -rf ./bin

.PHONY: run
run: setup ## runs go run the application
	go run ${GORACE} cmd/${APPLICATION}/main.go

.PHONY: build
build: clean ## build the server application
	GOOS=${GOOS} GOARCH=amd64 go build ${GORACE} -a -v -ldflags="-w -s" -o bin/${APPLICATION} cmd/${APPLICATION}/main.go

.PHONY: help
help: ## prints this help message
	@echo "Usage: \n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
