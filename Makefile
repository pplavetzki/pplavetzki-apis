ACR    = ${AZURE}
NAME   = ${ACR}.azurecr.io/pplavetzki-api
TAG    = $(shell git rev-parse HEAD)
IMG    = ${NAME}:${TAG}
LATEST = ${NAME}:latest
SUB = ${SUBSCRIPTION}
ACR_PSWD = ${ACR_PASSWORD}

.PHONY: all
all: build test publish

.PHONY: publish
publish: build-image login push

.PHONY: validation
validation: build test

.PHONY: test
test:
	docker build . -t pplavetzki-api-test:1 --target=testrunner
	docker run --rm pplavetzki-api-test:1
	docker image rm pplavetzki-api-test:1

.PHONY: build
build:
	go build -o apis

.PHONY: clean
clean:
	rm apis

.PHONY: build-image
build-image:
	docker build -t ${IMG} --target=executable .
	docker tag ${IMG} ${LATEST}

.PHONY: set-sub
set-sub:
	az account set --subscription ${SUB}

.PHONY: login
login:
	az acr login --name ${ACR} -u ${ACR} -p ${ACR_PSWD}

.PHONY: check-swagger
check-swagger:
	which swagger || (GO111MODULE=off go get -u github.com/go-swagger/go-swagger/cmd/swagger)

.PHONY: swagger
swagger: check-swagger
	GO111MODULE=on go mod vendor  && GO111MODULE=off swagger generate spec -o ./swagger.json --scan-models

.PHONY: push
push:
	docker push ${IMG}
	docker push ${LATEST}