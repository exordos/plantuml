SHELL := bash
REPOSITORY := https://repo.exordos.com/exordos-elements
EXORDOS_USER ?= admin
EXORDOS_PASSWORD ?= admin
ifeq ($(SSH_KEY),)
	SSH_KEY = ~/.ssh/id_rsa.pub
endif

all: help

help:
	@echo "build            - build element"
	@echo "install          - install element"

build:
	exordos build -i $(SSH_KEY) -f . --manifest-var repository=$(REPOSITORY)

install:
	version="$$(exordos -s -u $(EXORDOS_USER) -p $(EXORDOS_PASSWORD) get-version .)"; \
	exordos -u $(EXORDOS_USER) -p $(EXORDOS_PASSWORD) ee install "output/exordos-elements/plantuml_server/$${version}/manifests/plantuml_server.yaml"
