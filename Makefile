ACR    = ${AZURE}
NAME   = ${ACR}.azurecr.io/pplavetzki-api
TAG    = $(shell git rev-parse HEAD)
IMG    = ${NAME}:${TAG}
LATEST = ${NAME}:latest
SUB = ${SUBSCRIPTION}
ACR_PSWD = ${ACR_PASSWORD}

.PHONY: all
all: build-image login push

.PHONY: build
build:
	go build -o apis

.PHONY: clean
clean:
	rm apis

.PHONY: build-all
build-image:
	docker build -t ${IMG} .
	docker tag ${IMG} ${LATEST}

.PHONY: login
login:
	az acr login --name ${ACR} -u ${ACR} -p ${ACR_PSWD} --subscription ${SUB}

.PHONY: login-local
login-local:
	az acr login --name ${ACR} -u ${ACR} -p ${ACR_PSWD}

.PHONY: push
push:
	docker push ${IMG}
	docker push ${LATEST}